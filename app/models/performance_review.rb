class PerformanceReview < ApplicationRecord
  belongs_to :employee
  belongs_to :reviewer, class_name: "User", optional: true

  # Industry-standard KPI Structures
  KPI_TEMPLATES = {
    'Operations' => [
      { key: 'shipments_processed', label: 'Shipments processed per day', unit: 'shipments' },
      { key: 'clearance_time', label: 'Clearance time', unit: 'hours' },
      { key: 'cost_accuracy', label: 'Cost accuracy', unit: '%' }
    ],
    'Sales' => [
      { key: 'revenue_generated', label: 'Revenue generated', unit: 'ZAR' },
      { key: 'margin_achieved', label: 'Margin achieved', unit: '%' }
    ],
    'Warehouse' => [
      { key: 'inventory_accuracy', label: 'Inventory accuracy', unit: '%' },
      { key: 'damage_ratio', label: 'Damage ratio', unit: '%' }
    ]
  }.freeze

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :status, presence: true

  def overall_kpi_score
    return 0 if kpi_results.blank?
    
    # Simple average logic for example, in real-world this would be weighted
    scores = kpi_results.values.map(&:to_f)
    (scores.sum / scores.size).round(2)
  end
end
