class WarehouseTransaction < ApplicationRecord
  TYPES = ['receiving', 'picking', 'packing', 'transfer', 'adjustment', 'cross_dock'].freeze

  belongs_to :inventory_item
  belongs_to :client
  belongs_to :user, optional: true
  belongs_to :from_location, class_name: 'WarehouseLocation', optional: true
  belongs_to :to_location, class_name: 'WarehouseLocation', optional: true

  validates :transaction_type, inclusion: { in: TYPES }
  validates :quantity, numericality: { greater_than: 0 }
end
