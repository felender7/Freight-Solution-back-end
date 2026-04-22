class StorageBilling < ApplicationRecord
  STATUSES = ['pending', 'invoiced', 'paid'].freeze

  belongs_to :client

  validates :billing_date, presence: true
  validates :status, inclusion: { in: STATUSES }

  # Automated billing calculation
  def self.calculate_daily_for_client(client, date = Date.today)
    total_pallets = client.pallets.where(status: 'active').count
    # In a real system, you might sum volume of all items
    total_vol = InventoryRecord.where(client: client).joins(:inventory_item).sum("quantity * inventory_items.unit_volume")
    
    # Assume a standard daily rate from client profile or default
    daily_rate = 15.50 # This could be R15.50 per pallet per day
    
    amount = total_pallets * daily_rate
    
    create!(
      client: client,
      billing_date: date,
      total_pallets: total_pallets,
      total_volume: total_vol,
      daily_rate: daily_rate,
      amount: amount,
      status: 'pending'
    )
  end
end
