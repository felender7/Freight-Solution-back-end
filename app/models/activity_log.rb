class ActivityLog < ApplicationRecord
  belongs_to :actor, class_name: "User", optional: true
  belongs_to :entity, polymorphic: true, optional: true
end
