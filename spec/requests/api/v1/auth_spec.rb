require 'rails_helper'

RSpec.describe 'Api::V1::Auth', type: :request do
  path '/api/v1/auth/login' do
    post 'Login' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'Login successful' do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string },
                first_name: { type: :string },
                last_name: { type: :string },
                role: { type: :string }
              }
            }
          }

        let(:credentials) do
          { email: 'user@example.com', password: 'password' }
        end
        run_test!
      end

      response '401', 'Invalid credentials' do
        let(:credentials) do
          { email: 'invalid@example.com', password: 'wrong' }
        end
        run_test!
      end
    end
  end

  path '/api/v1/auth/logout' do
    post 'Logout' do
      tags 'Authentication'
      produces 'application/json'

      response '200', 'Logout successful' do
        run_test!
      end
    end
  end

  path '/api/v1/auth/me' do
    get 'Current User' do
      tags 'Authentication'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns current user' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string },
            first_name: { type: :string },
            last_name: { type: :string },
            role: { type: :string }
          }
        run_test!
      end
    end
  end
end
