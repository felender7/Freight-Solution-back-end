require 'rails_helper'

RSpec.describe 'Api::V1::Hrm', type: :request do
  path '/api/v1/hrm/me' do
    get 'Get Current Employee Profile' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns employee profile' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            first_name: { type: :string },
            last_name: { type: :string },
            email: { type: :string },
            phone: { type: :string },
            position: { type: :string },
            department: { type: :string },
            hire_date: { type: :string, format: 'date' }
          }
        run_test!
      end
    end

    patch 'Update Current Employee Profile' do
      tags 'HRM'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :profile, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          phone: { type: :string }
        }
      }

      response '200', 'Profile updated' do
        let(:profile) { { phone: '1234567890' } }
        run_test!
      end
    end
  end

  path '/api/v1/hrm/attendance_records' do
    get 'List Attendance Records' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns attendance records' do
        run_test!
      end
    end

    post 'Create Attendance Record' do
      tags 'HRM'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '201', 'Attendance record created' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/attendance_records/clock_in' do
    post 'Clock In' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Clocked in successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/attendance_records/clock_out' do
    post 'Clock Out' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Clocked out successfully' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/performance_reviews' do
    get 'List Performance Reviews' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns performance reviews' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/performance_reviews/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Performance Review' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns performance review' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/hrm/leave_requests' do
    get 'List Leave Requests' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns leave requests' do
        run_test!
      end
    end

    post 'Create Leave Request' do
      tags 'HRM'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :leave_request, in: :body, schema: {
        type: :object,
        properties: {
          leave_type: { type: :string },
          start_date: { type: :string, format: 'date' },
          end_date: { type: :string, format: 'date' },
          reason: { type: :string }
        },
        required: [ 'leave_type', 'start_date', 'end_date' ]
      }

      response '201', 'Leave request created' do
        let(:leave_request) do
          { leave_type: 'annual', start_date: '2024-02-01', end_date: '2024-02-05', reason: 'Vacation' }
        end
        run_test!
      end
    end
  end

  path '/api/v1/hrm/leave_requests/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Leave Request' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns leave request' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/hrm/tasks' do
    get 'List Tasks' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns tasks' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/tasks/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Task' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns task' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/hrm/timesheets' do
    get 'List Timesheets' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns timesheets' do
        run_test!
      end
    end

    post 'Create Timesheet' do
      tags 'HRM'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :timesheet, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string, format: 'date' },
          hours_worked: { type: :number },
          description: { type: :string }
        },
        required: [ 'date', 'hours_worked' ]
      }

      response '201', 'Timesheet created' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/training_courses' do
    get 'List Training Courses' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns training courses' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/training_courses/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Training Course' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns training course' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/hrm/training_courses/{id}/enroll' do
    parameter name: :id, in: :path, type: :integer

    post 'Enroll in Training Course' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Enrolled successfully' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/hrm/enrollments' do
    get 'List Enrollments' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns enrollments' do
        run_test!
      end
    end
  end

  path '/api/v1/hrm/enrollments/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Enrollment' do
      tags 'HRM'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns enrollment' do
        let(:id) { 1 }
        run_test!
      end
    end
  end
end
