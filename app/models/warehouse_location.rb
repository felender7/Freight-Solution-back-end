class WarehouseLocation < ApplicationRecord
  belongs_to :user, optional: true

  LOCATION_TYPES = ['receiving', 'storage', 'cross_dock', 'shipping', 'inspection'].freeze
  ZONES = ['Dry', 'Cold Storage', 'Dangerous Goods', 'High Value', 'Bulk'].freeze

  has_many :inventory_records
  has_many :pallets

  validates :name, presence: true, uniqueness: true
  validates :location_type, inclusion: { in: LOCATION_TYPES }
  validates :zone, inclusion: { in: ZONES }

  def available_volume
    capacity_volume - current_volume
  end

  def available_weight
    capacity_weight - current_weight
  end

  def utilization_percentage
    return 0 if capacity_volume.to_f == 0
    (current_volume.to_f / capacity_volume.to_f * 100).round(2)
  end

  # AI-inspired space optimization helper
  # Suggests if an item of given volume/weight fits here
  def fits?(volume, weight)
    !is_full && available_volume >= volume && available_weight >= weight
  end
end
