class Vendor < ApplicationRecord
  CATEGORIES = [
    "Shipping lines",
    "Airlines",
    "Road transporters",
    "Warehouse operators",
    "Customs brokers",
    "Insurance providers",
    "Inspection agencies"
  ].freeze

  KYC_STATUSES = [ "pending", "in_progress", "verified", "rejected" ].freeze

  has_one_attached :company_registration_doc
  has_one_attached :tax_clearance_doc
  has_one_attached :insurance_certificate_doc
  has_one_attached :bank_confirmation_letter_doc
  has_one_attached :bbbee_certificate_doc
  has_many_attached :contracts

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
  validates :kyc_status, inclusion: { in: KYC_STATUSES }, allow_nil: true
  validates :risk_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

  scope :search_by, ->(query) {
    where("name ILIKE :q OR email ILIKE :q OR phone ILIKE :q OR bank_reference ILIKE :q", q: "%#{query}%")
  }
  scope :filter_by_category, ->(category) { where(category: category) }
  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_kyc_status, ->(kyc_status) { where(kyc_status: kyc_status) }

  def contract_status
    return "No Contract" if contract_end_date.blank?
    return "Expired" if contract_end_date < Date.today
    return "Expiring Soon" if contract_end_date < 30.days.from_now.to_date
    "Active"
  end
end
