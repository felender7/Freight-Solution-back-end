# Be sure to restart your server when you modify this file.

# Explicitly require rack-cors
require "rack/cors"

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Allow all origins for mobile app access
    origins '*'

    # Allow all paths
    resource "*",
      # Allow all headers
      headers: :any,
      # Allow all common HTTP methods
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      # Cache preflight response for 10 minutes
      max_age: 600,
      # Expose Authorization header for token auth
      expose: [ "Authorization" ]
  end
end
