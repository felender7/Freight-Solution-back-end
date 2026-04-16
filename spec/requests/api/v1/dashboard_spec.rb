require 'rails_helper'

RSpec.describe 'Api::V1::Dashboard', type: :request do
  path '/api/v1/dashboard/stats' do
    get 'Get Dashboard Statistics' do
      tags 'Dashboard'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns dashboard statistics' do
        schema type: :object,
          properties: {
            total_shipments: { type: :integer },
            pending_invoices: { type: :integer },
            total_employees: { type: :integer },
            active_shipments: { type: :integer }
          }
        run_test!
      end
    end
  end
end
