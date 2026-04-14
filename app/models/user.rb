class User < ApplicationRecord
  has_secure_password

  before_validation :set_default_values

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin user] }

  def set_default_values
    self.role ||= "user"
    self.must_update_password = true if must_update_password.nil?
  end

  def to_token_payload
    {
      sub: id,
      email: email,
      role: role
    }
  end
end
