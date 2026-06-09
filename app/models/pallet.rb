class Pallet < ApplicationRecord
  STATUSES = ['active', 'in_transit', 'shipped', 'broken'].freeze

  belongs_to :client
  belongs_to :warehouse_location, optional: true
  has_many :inventory_records

  validates :pallet_number, presence: true, uniqueness: true
  validates :status, inclusion: { in: STATUSES }

  def total_items
    inventory_records.sum(:quantity)
  end
end
