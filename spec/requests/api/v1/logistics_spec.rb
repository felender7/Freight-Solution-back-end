require 'swagger_helper'

RSpec.describe 'Api::V1::Logistics', type: :request do
  path '/api/v1/logistics/bookings' do
    get 'List Bookings' do
      tags 'Logistics'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns list of bookings' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              booking_reference: { type: :string },
              origin: { type: :string },
              destination: { type: :string },
              ship_date: { type: :string, format: 'date' },
              estimated_arrival: { type: :string, format: 'date' },
              status: { type: :string },
              container_number: { type: :string }
            }
          }
        run_test!
      end
    end

    post 'Create Booking' do
      tags 'Logistics'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :booking, in: :body, schema: {
        type: :object,
        properties: {
          booking_reference: { type: :string },
          origin: { type: :string },
          destination: { type: :string },
          ship_date: { type: :string, format: 'date' },
          estimated_arrival: { type: :string, format: 'date' },
          status: { type: :string },
          container_number: { type: :string }
        },
        required: [ 'booking_reference', 'origin', 'destination' ]
      }

      response '201', 'Booking created' do
        let(:booking) do
          {
            booking_reference: 'BK001',
            origin: 'Johannesburg',
            destination: 'Cape Town',
            ship_date: '2024-01-15',
            estimated_arrival: '2024-01-20',
            status: 'pending',
            container_number: 'CONT001'
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/logistics/bookings/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Booking' do
      tags 'Logistics'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns booking' do
        let(:id) { 1 }
        run_test!
      end

      response '404', 'Booking not found' do
        let(:id) { 999 }
        run_test!
      end
    end

    put 'Update Booking' do
      tags 'Logistics'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :booking, in: :body, schema: {
        type: :object,
        properties: {
          booking_reference: { type: :string },
          origin: { type: :string },
          destination: { type: :string },
          status: { type: :string }
        }
      }

      response '200', 'Booking updated' do
        let(:id) { 1 }
        let(:booking) { { status: 'completed' } }
        run_test!
      end
    end

    delete 'Delete Booking' do
      tags 'Logistics'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Booking deleted' do
        let(:id) { 1 }
        run_test!
      end
    end
  end
end
