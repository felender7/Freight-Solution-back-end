require 'swagger_helper'

RSpec.describe 'Api::V1::Warehouse', type: :request do
  path '/api/v1/warehouse/inventory' do
    get 'List Inventory' do
      tags 'Warehouse'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns list of inventory items' do
        run_test!
      end
    end

    post 'Create Inventory Item' do
      tags 'Warehouse'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          quantity: { type: :integer },
          location: { type: :string }
        },
        required: [ 'name', 'quantity' ]
      }

      response '201', 'Inventory item created' do
        let(:item) { { name: 'Widget', quantity: 100, location: 'Warehouse A' } }
        run_test!
      end
    end
  end

  path '/api/v1/warehouse/inventory/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Inventory Item' do
      tags 'Warehouse'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns inventory item' do
        let(:id) { 1 }
        run_test!
      end
    end

    put 'Update Inventory Item' do
      tags 'Warehouse'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Inventory item updated' do
        let(:id) { 1 }
        let(:item) { { quantity: 50 } }
        run_test!
      end
    end

    delete 'Delete Inventory Item' do
      tags 'Warehouse'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Inventory item deleted' do
        let(:id) { 1 }
        run_test!
      end
    end
  end

  path '/api/v1/warehouse/transfers' do
    get 'List Transfers' do
      tags 'Warehouse'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns list of transfers' do
        run_test!
      end
    end

    post 'Create Transfer' do
      tags 'Warehouse'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :transfer, in: :body, schema: {
        type: :object,
        properties: {
          item_id: { type: :integer },
          from_location: { type: :string },
          to_location: { type: :string },
          quantity: { type: :integer }
        },
        required: [ 'item_id', 'from_location', 'to_location', 'quantity' ]
      }

      response '201', 'Transfer created' do
        run_test!
      end
    end
  end

  path '/api/v1/warehouse/locations' do
    get 'List Locations' do
      tags 'Warehouse'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns list of warehouse locations' do
        run_test!
      end
    end
  end
end
