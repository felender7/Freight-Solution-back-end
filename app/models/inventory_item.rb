class InventoryItem < ApplicationRecord
  belongs_to :user, optional: true

  has_many :inventory_records
  has_many :warehouse_transactions

  validates :name, :sku, presence: true
  validates :sku, uniqueness: true
  validates :barcode, uniqueness: true, allow_blank: true

  before_create :generate_barcode

  def total_quantity
    inventory_records.sum(:quantity)
  end

  private

  def generate_barcode
    self.barcode ||= "SKU-#{sku}-#{SecureRandom.hex(4).upcase}" if sku.present?
  end
end
