class Api::V1::Hrm::AttendanceRecordsController < Api::V1::Hrm::BaseController
  def index
    start_date = params[:start_date]&.to_date || Date.today.beginning_of_month
    end_date = params[:end_date]&.to_date || Date.today.end_of_month

    @attendance_records = current_employee.attendance_records
      .where(date: start_date..end_date)
      .order(date: :desc, clock_in: :desc)

    render json: {
      records: @attendance_records,
      summary: {
        total_days: @attendance_records.count,
        present: @attendance_records.where(status: "present").count,
        absent: @attendance_records.where(status: "absent").count,
        late: @attendance_records.where(status: "late").count,
        total_hours: calculate_total_hours(@attendance_records)
      }
    }
  end

  def current_status
    if AttendanceRecord.has_active_session?(current_employee.id)
      session = AttendanceRecord.current_session(current_employee.id)
      render json: {
        status: "clocked_in",
        clock_in: session.clock_in,
        date: session.date,
        duration: session.duration,
        record: session
      }
    else
      render json: {
        status: "clocked_out",
        last_clock_out: current_employee.attendance_records.completed.last&.clock_out
      }
    end
  end

  def clock_in
    if AttendanceRecord.has_active_session?(current_employee.id)
      return render json: {
        error: "You already have an active session",
        code: "ALREADY_CLOCKED_IN"
      }, status: :unprocessable_entity
    end

    today = Date.today

    if current_employee.attendance_records.where(date: today).exists?
      return render json: {
        error: "You have already clocked in today",
        code: "ALREADY_CLOCKED_IN_TODAY"
      }, status: :unprocessable_entity
    end

    @attendance_record = current_employee.attendance_records.new(
      clock_in: Time.current,
      date: today,
      ip_address: request.remote_ip,
      user_id: current_user.id,
      status: determine_status
    )

    if @attendance_record.save
      render json: {
        message: "Clocked in successfully",
        record: @attendance_record,
        status: "clocked_in"
      }, status: :created
    else
      render json: {
        error: @attendance_record.errors.full_messages.join(", "),
        code: "CLOCK_IN_FAILED"
      }, status: :unprocessable_entity
    end
  end

  def clock_out
    session = AttendanceRecord.current_session(current_employee.id)

    unless session
      return render json: {
        error: "No active clock-in session found",
        code: "NO_ACTIVE_SESSION"
      }, status: :not_found
    end

    clock_out_time = Time.current

    if clock_out_time < session.clock_in
      return render json: {
        error: "Clock-out time cannot be before clock-in time",
        code: "INVALID_CLOCK_OUT"
      }, status: :unprocessable_entity
    end

    session.assign_attributes(
      clock_out: clock_out_time,
      ip_address: request.remote_ip
    )

    if session.save
      render json: {
        message: "Clocked out successfully",
        record: session,
        status: "clocked_out",
        duration: session.duration,
        working_hours: session.working_hours
      }
    else
      render json: {
        error: session.errors.full_messages.join(", "),
        code: "CLOCK_OUT_FAILED"
      }, status: :unprocessable_entity
    end
  end

  def show
    @attendance_record = current_employee.attendance_records.find(params[:id])
    render json: @attendance_record
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Record not found" }, status: :not_found
  end

  private

  def determine_status
    scheduled_start = Time.current.change(hour: 8, min: 0)
    if Time.current > scheduled_start + 15.minutes
      "late"
    else
      "present"
    end
  end

  def calculate_total_hours(records)
    total_seconds = records.completed.sum do |record|
      next 0 unless record.clock_in && record.clock_out
      record.clock_out - record.clock_in
    end
    (total_seconds / 3600).round(2)
  end
end
