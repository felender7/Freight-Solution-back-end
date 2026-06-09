class Invoice < ApplicationRecord
  belongs_to :vendor, optional: true
  belongs_to :user, optional: true
end
