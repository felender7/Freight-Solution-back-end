class Vendor < ApplicationRecord
  # Categories as defined in requirements
  CATEGORIES = [
    'Shipping lines',
    'Airlines',
    'Road transporters',
    'Warehouse operators',
    'Customs brokers',
    'Insurance providers',
    'Inspection agencies'
  ].freeze

  KYC_STATUSES = ['pending', 'in_progress', 'verified', 'rejected'].freeze

  # Attachments for compliance documents
  has_one_attached :company_registration_doc
  has_one_attached :tax_clearance_doc
  has_one_attached :insurance_certificate_doc
  has_one_attached :bank_confirmation_letter_doc
  has_one_attached :bbbee_certificate_doc
  has_many_attached :contracts

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
  validates :kyc_status, inclusion: { in: KYC_STATUSES }
  validates :risk_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def contract_status
    return 'No Contract' if contract_end_date.blank?
    return 'Expired' if contract_end_date < Date.today
    return 'Expiring Soon' if contract_end_date < 30.days.from_now.to_date
    'Active'
  end
end
