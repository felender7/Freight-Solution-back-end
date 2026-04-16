class Admin::AttendanceRecordsController < Admin::BaseController
  before_action :set_attendance_record, only: [ :show, :edit, :update, :destroy ]

  def index
    @attendance_records = AttendanceRecord.includes(:employee, :user).order(date: :desc)
  end

  def show
  end

  def new
    @attendance_record = AttendanceRecord.new
    @employees = Employee.all
    @users = User.all
  end

  def create
    @attendance_record = AttendanceRecord.new(attendance_record_params)
    if @attendance_record.save
      redirect_to admin_attendance_records_path, notice: "Attendance record was successfully created."
    else
      @employees = Employee.all
      @users = User.all
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @employees = Employee.all
    @users = User.all
  end

  def update
    if @attendance_record.update(attendance_record_params)
      redirect_to admin_attendance_records_path, notice: "Attendance record was successfully updated."
    else
      @employees = Employee.all
      @users = User.all
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @attendance_record.destroy
    redirect_to admin_attendance_records_path, notice: "Attendance record was successfully deleted."
  end

  private

  def set_attendance_record
    @attendance_record = AttendanceRecord.find(params[:id])
  end

  def attendance_record_params
    params.require(:attendance_record).permit(:employee_id, :user_id, :clock_in, :clock_out, :date, :status, :ip_address)
  end
end
