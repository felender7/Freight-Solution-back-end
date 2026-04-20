Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get "up" => "rails/health#show", as: :rails_health_check

  # Admin routes
  get "admin/login" => "admin#login"
  post "admin/login" => "admin#login"
  get "admin/logout" => "admin#logout"

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    get "hrm", to: "hrm_dashboard#index"
    resources :users
    resources :employees
    resources :vendors
    resources :shipments
    resources :invoices
    resources :performance_reviews
    resources :attendance_records
    resources :leave_requests
    resources :hrm_tasks
    resources :timesheets
    resources :training_courses
  end

namespace :api do
    namespace :v1 do
      post "auth/login", to: "auth#login"
      post "auth/logout", to: "auth#logout"
      post "auth/update_password", to: "auth#update_password"
      get "auth/me", to: "auth#me"
      get "dashboard/stats", to: "dashboard#stats"

      resources :vendors
      get "logistics/bookings", to: "logistics#bookings"
      post "logistics/bookings", to: "logistics#bookings"
      get "logistics/bookings/:id", to: "logistics#booking"
      put "logistics/bookings/:id", to: "logistics#booking"
      delete "logistics/bookings/:id", to: "logistics#booking"

      get "warehouse/inventory", to: "warehouse#inventory"
      post "warehouse/inventory", to: "warehouse#inventory"
      get "warehouse/inventory/:id", to: "warehouse#item"
      put "warehouse/inventory/:id", to: "warehouse#item"
      delete "warehouse/inventory/:id", to: "warehouse#item"
      get "warehouse/transfers", to: "warehouse#transfers"
      post "warehouse/transfers", to: "warehouse#transfers"
      get "warehouse/locations", to: "warehouse#locations"

      namespace :hrm do
        get "me", to: "profile#show"
        patch "me", to: "profile#update"
        resources :attendance_records, only: [:index, :create] do
          post "clock_in", on: :collection
          post "clock_out", on: :collection
        end
        resources :performance_reviews, only: [:index, :show, :update]
        resources :leave_requests, only: [:index, :create, :show, :destroy]
        resources :tasks, only: [:index, :show, :update]
        resources :timesheets, only: [:index, :create, :show, :destroy]
        resources :training_courses, only: [:index, :show] do
          post "enroll", on: :member
        end
        resources :enrollments, only: [:index, :show, :update]
      end
    end
  end

  root "admin#login"
end
