class AddKpiResultsToPerformanceReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :performance_reviews, :kpi_results, :jsonb, default: {}
    add_index :performance_reviews, :kpi_results, using: :gin
  end
end
