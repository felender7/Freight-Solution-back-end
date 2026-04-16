class Admin::HrmDashboardController < Admin::BaseController
  def index
    @total_employees = Employee.count
    @total_users = User.where(role: [ "employee", "hr_manager" ]).count
    @pending_leaves = LeaveRequest.where(status: "pending").count
    @pending_timesheets = Timesheet.where(status: "pending").count
    @attendance_today = AttendanceRecord.where(date: Date.today).count
    @active_tasks = Task.where.not(status: "done").count
    @training_courses = TrainingCourse.where(is_active: true).count
    @performance_reviews = PerformanceReview.count

    @recent_attendance = AttendanceRecord.includes(:employee).order(date: :desc).limit(5)
    @recent_leaves = LeaveRequest.includes(:employee).order(created_at: :desc).limit(5)
    @recent_tasks = Task.includes(:employee).order(created_at: :desc).limit(5)
  end
end
