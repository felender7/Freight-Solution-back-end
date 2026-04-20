require 'swagger_helper'

RSpec.describe 'Api::V1::Vendors', type: :request do
  path '/api/v1/vendors' do
    get 'List Vendors' do
      tags 'Vendors'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns list of vendors' do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              email: { type: :string },
              phone: { type: :string },
              address: { type: :string },
              bank_reference: { type: :string },
              status: { type: :string },
              created_at: { type: :string, format: 'date-time' },
              updated_at: { type: :string, format: 'date-time' }
            }
          }

        let(:Authorization) { 'Bearer dummy_token' }
        
        before do
          allow(JsonWebToken).to receive(:decode).and_return({ sub: 1 })
          allow(User).to receive(:find_by).and_return(User.new(id: 1))
          vendor = Vendor.new(
            id: 1,
            name: 'Vendor 1',
            email: 'vendor1@example.com',
            phone: '1234567890',
            address: '123 Main St',
            bank_reference: 'BR123',
            status: 'active',
            created_at: Time.now,
            updated_at: Time.now
          )
          allow(Vendor).to receive(:all).and_return([vendor])
        end

        run_test!
      end
    end

    post 'Create Vendor' do
      tags 'Vendors'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :vendor, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          phone: { type: :string },
          address: { type: :string },
          bank_reference: { type: :string },
          status: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'Vendor created' do
        let(:Authorization) { 'Bearer dummy_token' }
        let(:vendor) { { name: 'New Vendor', email: 'vendor@example.com' } }

        before do
          allow(JsonWebToken).to receive(:decode).and_return({ sub: 1 })
          allow(User).to receive(:find_by).and_return(User.new(id: 1))
        end

        run_test!
      end
    end
  end

  path '/api/v1/vendors/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Get Vendor' do
      tags 'Vendors'
      produces 'application/json'
      security [ BearerAuth: [] ]

      response '200', 'Returns vendor' do
        let(:Authorization) { 'Bearer dummy_token' }
        let(:id) { 1 }

        before do
          allow(JsonWebToken).to receive(:decode).and_return({ sub: 1 })
          allow(User).to receive(:find_by).and_return(User.new(id: 1))
          allow(Vendor).to receive(:find).with('1').and_return(Vendor.new(id: 1, name: 'Vendor 1'))
        end

        run_test!
      end

      response '404', 'Vendor not found' do
        let(:Authorization) { 'Bearer dummy_token' }
        let(:id) { 999 }

        before do
          allow(JsonWebToken).to receive(:decode).and_return({ sub: 1 })
          allow(User).to receive(:find_by).and_return(User.new(id: 1))
          allow(Vendor).to receive(:find).with('999').and_raise(ActiveRecord::RecordNotFound)
        end

        run_test!
      end
    end

    put 'Update Vendor' do
      tags 'Vendors'
      consumes 'application/json'
      produces 'application/json'
      security [ BearerAuth: [] ]

      parameter name: :vendor_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :string }
        }
      }

      response '200', 'Vendor updated' do
        let(:Authorization) { 'Bearer dummy_token' }
        let(:id) { 1 }
        let(:vendor_params) { { name: 'Updated Vendor' } }

        before do
          allow(JsonWebToken).to receive(:decode).and_return({ sub: 1 })
          allow(User).to receive(:find_by).and_return(User.new(id: 1))
          vendor = Vendor.new(id: 1, name: 'Vendor 1')
          allow(Vendor).to receive(:find).with('1').and_return(vendor)
          allow(vendor).to receive(:update).and_return(true)
        end

        run_test!
      end
    end

    delete 'Delete Vendor' do
      tags 'Vendors'
      security [ BearerAuth: [] ]

      response '204', 'Vendor deleted' do
        let(:Authorization) { 'Bearer dummy_token' }
        let(:id) { 1 }

        before do
          allow(JsonWebToken).to receive(:decode).and_return({ sub: 1 })
          allow(User).to receive(:find_by).and_return(User.new(id: 1))
          vendor = Vendor.new(id: 1, name: 'Vendor 1')
          allow(Vendor).to receive(:find).with('1').and_return(vendor)
          allow(vendor).to receive(:destroy).and_return(true)
        end

        run_test!
      end
    end
  end
end
