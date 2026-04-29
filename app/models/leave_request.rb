class LeaveRequest < ApplicationRecord
  belongs_to :employee
  belongs_to :approved_by, class_name: "User", optional: true
  belongs_to :user, optional: true

  has_one_attached :medical_certificate
  has_one_attached :study_timetable

  enum :leave_type, {
    sick: "sick",
    annual: "annual",
    maternity: "maternity",
    paternity: "paternity",
    unpaid: "unpaid",
    study: "study"
  }

  enum :status, {
    pending: "pending",
    approved: "approved",
    rejected: "rejected"
  }

  validates :leave_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validate :end_date_after_start_date
  validate :study_timetable_presence, if: -> { study? }

  def number_of_days
    return 0 if start_date.blank? || end_date.blank?
    (end_date - start_date).to_i + 1
  end

  def medical_certificate_attached
    medical_certificate.attached?
  end

  def study_timetable_attached
    study_timetable.attached?
  end

  def medical_certificate_url
    medical_certificate.url if medical_certificate.attached?
  end

  def study_timetable_url
    study_timetable.url if study_timetable.attached?
  end

  private

  def study_timetable_presence
    if !study_timetable.attached?
      errors.add(:study_timetable, "must be uploaded for study leave")
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
