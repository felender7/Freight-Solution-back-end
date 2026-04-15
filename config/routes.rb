Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Admin routes
  get "admin/login" => "admin#login"
  post "admin/login" => "admin#login"
  get "admin/logout" => "admin#logout"

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :users
    resources :employees
    resources :vendors
    resources :shipments
    resources :invoices
  end

namespace :api do
    namespace :v1 do
      post "auth/login", to: "auth#login"
      post "auth/logout", to: "auth#logout"
      post "auth/update_password", to: "auth#update_password"
      get "auth/me", to: "auth#me"
      get "dashboard/stats", to: "dashboard#stats"

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
    end
  end

  root "admin#login"
end
