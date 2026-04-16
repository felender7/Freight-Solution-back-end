# Freight Solution Backend

A Rails 8.1 backend application for Tswalanang Freight Solution - a comprehensive logistics and freight management system.

## Tech Stack

- **Framework**: Ruby on Rails 8.1
- **Database**: PostgreSQL
- **Authentication**: JWT + Secure Password
- **File Storage**: Cloudinary
- **Caching**: Solid Cache
- **Background Jobs**: Solid Queue

## Features

### Admin Portal
- User management (create, edit, delete users)
- Employee management with HRM features
- Vendor management
- Shipment tracking
- Invoice management
- Performance review management

### Human Resource Management (HRM)
- Employee profiles with detailed information
- Attendance tracking (clock in/out)
- Leave request management
- Performance reviews
- Task assignment
- Timesheet tracking
- Training course management and enrollment
- Activity logging

### API (RESTful)
- **Authentication**: JWT-based login/logout/password management
- **Logistics**: Booking management
- **Warehouse**: Inventory and transfer management
- **HRM API**: Employee self-service portal
  - View/update personal profile
  - Clock in/out functionality
  - View performance reviews
  - Submit leave requests
  - Task management
  - Timesheet submission
  - Training course enrollment

## Setup

### Prerequisites
- Ruby 3.2+
- PostgreSQL 14+
- Node.js (for asset compilation)

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd "Freight Solution-back-end"
```

2. Install dependencies
```bash
bundle install
```

3. Configure database
```bash
# Create database.yml from template
cp config/database.yml.example config/database.yml

# Edit database.yml with your PostgreSQL credentials
```

4. Setup database
```bash
rails db:create db:migrate db:seed
```

5. Start the server
```bash
rails server
```

## Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Required variables:
- `DATABASE_URL` - PostgreSQL connection string
- `SECRET_KEY_BASE` - Rails secret key (run `rails secret` to generate)

## API Endpoints

### Authentication
- `POST /api/v1/auth/login` - Login
- `POST /api/v1/auth/logout` - Logout
- `POST /api/v1/auth/update_password` - Update password
- `GET /api/v1/auth/me` - Current user info

### Dashboard
- `GET /api/v1/dashboard/stats` - Get statistics

### Logistics
- `GET /api/v1/logistics/bookings` - List bookings
- `POST /api/v1/logistics/bookings` - Create booking
- `GET /api/v1/logistics/bookings/:id` - Get booking
- `PUT /api/v1/logistics/bookings/:id` - Update booking
- `DELETE /api/v1/logistics/bookings/:id` - Delete booking

### Warehouse
- `GET /api/v1/warehouse/inventory` - List inventory
- `POST /api/v1/warehouse/inventory` - Add inventory item
- `GET /api/v1/warehouse/inventory/:id` - Get item
- `PUT /api/v1/warehouse/inventory/:id` - Update item
- `DELETE /api/v1/warehouse/inventory/:id` - Delete item
- `GET /api/v1/warehouse/transfers` - List transfers
- `POST /api/v1/warehouse/transfers` - Create transfer
- `GET /api/v1/warehouse/locations` - List locations

### HRM API
- `GET /api/v1/hrm/me` - Get current employee profile
- `PATCH /api/v1/hrm/me` - Update profile
- `GET /api/v1/hrm/attendance_records` - List attendance
- `POST /api/v1/hrm/attendance_records/clock_in` - Clock in
- `POST /api/v1/hrm/attendance_records/clock_out` - Clock out
- `GET /api/v1/hrm/performance_reviews` - List reviews
- `GET /api/v1/hrm/leave_requests` - List leave requests
- `POST /api/v1/hrm/leave_requests` - Create leave request
- `GET /api/v1/hrm/tasks` - List tasks
- `GET /api/v1/hrm/timesheets` - List timesheets
- `POST /api/v1/hrm/timesheets` - Create timesheet
- `GET /api/v1/hrm/training_courses` - List courses
- `POST /api/v1/hrm/training_courses/:id/enroll` - Enroll in course

## Admin Routes

- `/admin/login` - Admin login
- `/admin/dashboard` - Admin dashboard
- `/admin/hrm` - HRM dashboard

Admin resources: `/admin/users`, `/admin/employees`, `/admin/vendors`, `/admin/shipments`, `/admin/invoices`, `/admin/performance_reviews`, `/admin/attendance_records`, `/admin/leave_requests`, `/admin/hrm_tasks`, `/admin/timesheets`, `/admin/training_courses`

## Development

Run tests:
```bash
rails test
```

Security audits:
```bash
bundle exec brakeman
bundle exec bundler-audit
```

## License

Proprietary - Tswalanang Freight Solution