class InventoryRecord < ApplicationRecord
  belongs_to :inventory_item
  belongs_to :client
  belongs_to :warehouse_location
  belongs_to :pallet, optional: true

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_location_utilization
  after_destroy :update_location_utilization

  private

  def update_location_utilization
    # Simple logic to update current used volume/weight in location
    # Real AI space optimization would be more complex
    location = warehouse_location
    records = location.inventory_records.includes(:inventory_item)
    
    total_vol = records.sum { |r| r.quantity * r.inventory_item.unit_volume }
    total_wgt = records.sum { |r| r.quantity * r.inventory_item.unit_weight }
    
    location.update(current_volume: total_vol, current_weight: total_wgt)
  end
end
