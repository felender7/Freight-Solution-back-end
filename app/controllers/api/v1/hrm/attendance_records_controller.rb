class Api::V1::Hrm::AttendanceRecordsController < Api::V1::Hrm::BaseController
  def index
    @attendance_records = current_employee.attendance_records.order(date: :desc, clock_in: :desc)
    render json: @attendance_records
  end

  def clock_in
    if current_employee.attendance_records.where(date: Date.today, clock_out: nil).exists?
      return render json: { error: "You are already clocked in" }, status: :unprocessable_entity
    end

    @attendance_record = current_employee.attendance_records.create!(
      clock_in: Time.current,
      date: Date.today,
      ip_address: request.remote_ip,
      status: "present"
    )

    render json: @attendance_record, status: :created
  end

  def clock_out
    @attendance_record = current_employee.attendance_records.where(date: Date.today, clock_out: nil).last

    if @attendance_record
      @attendance_record.update!(clock_out: Time.current)
      render json: @attendance_record
    else
      render json: { error: "No active clock-in found for today" }, status: :not_found
    end
  end
end
