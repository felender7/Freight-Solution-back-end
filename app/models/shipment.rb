class Shipment < ApplicationRecord
  belongs_to :user, optional: true
end
