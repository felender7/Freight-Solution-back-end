class Invoice < ApplicationRecord
  belongs_to :vendor, optional: true
end
