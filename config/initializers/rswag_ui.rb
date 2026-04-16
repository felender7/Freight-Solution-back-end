Rswag::Ui.configure do |c|
  c.openapi_endpoint "/api-docs/v1/swagger.yaml", "API V1 Docs"
  # Configure the route format for OpenAPI specs
  c.api_listener_path = "/api-docs"
end
