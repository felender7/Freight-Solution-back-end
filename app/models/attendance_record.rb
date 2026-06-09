class AttendanceRecord < ApplicationRecord
  belongs_to :employee
  belongs_to :user, optional: true

  validates :employee_id, presence: true
  validates :date, presence: true
  validates :clock_in, presence: { message: "is required" }
  validate :clock_out_after_clock_in, if: -> { clock_out.present? }
  validate :no_overlapping_records, on: :create

  scope :for_date, ->(date) { where(date: date) }
  scope :for_employee, ->(employee_id) { where(employee_id: employee_id) }
  scope :active_sessions, -> { where(clock_out: nil) }
  scope :completed, -> { where.not(clock_out: nil) }
  scope :today, -> { for_date(Date.today) }

  def self.has_active_session?(employee_id)
    active_sessions.for_employee(employee_id).today.exists?
  end

  def self.current_session(employee_id)
    active_sessions.for_employee(employee_id).today.last
  end

  def active?
    clock_out.nil?
  end

  def completed?
    clock_out.present?
  end

  def working_hours
    return nil unless clock_out.present?
    ((clock_out - clock_in) / 1.hour).round(2)
  end

  def duration
    return nil unless clock_out.present?
    seconds = clock_out - clock_in
    hours = seconds / 3600
    minutes = (seconds % 3600) / 60
    "#{hours.to_i}h #{minutes.to_i}m"
  end

  private

  def clock_out_after_clock_in
    if clock_out < clock_in
      errors.add(:clock_out, "must be after clock-in time")
    end
  end

  def no_overlapping_records
    if employee_id.present? && date.present?
      if self.class.for_employee(employee_id).for_date(date).active_sessions.exists?
        errors.add(:base, "An active session already exists for this date")
      end
    end
  end
end
