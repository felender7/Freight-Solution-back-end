class Client < ApplicationRecord
  # Categories as defined in requirements
  CATEGORIES = [
    'Exporter',
    'Importer',
    'Clearing client',
    'Government client',
    'Enterprise',
    'SME'
  ].freeze

  KYC_STATUSES = ['pending', 'in_progress', 'verified', 'rejected'].freeze
  PAYMENT_TERMS = ['Immediate', 'Net 15', 'Net 30', 'Net 60', 'Custom'].freeze
  RISK_CATEGORIES = ['Low', 'Medium', 'High', 'Critical'].freeze

  # ActiveStorage Attachments for KYC
  has_one_attached :registration_doc
  has_one_attached :director_id_doc
  has_one_attached :bank_confirmation_doc
  has_one_attached :tax_compliance_doc
  has_one_attached :proof_of_address_doc
  has_many_attached :trade_references_docs

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
  validates :kyc_status, inclusion: { in: KYC_STATUSES }
  validates :risk_category, inclusion: { in: RISK_CATEGORIES }, allow_blank: true
  validates :payment_terms, inclusion: { in: PAYMENT_TERMS }, allow_blank: true
  validates :credit_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  def financial_risk_profile
    return 'Critical' if credit_score < 30 || fx_exposure > (credit_limit * 1.5)
    return 'High' if credit_score < 50
    return 'Medium' if credit_score < 80
    'Low'
  end
end
