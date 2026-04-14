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
    end
  end

  root "admin#login"
end
