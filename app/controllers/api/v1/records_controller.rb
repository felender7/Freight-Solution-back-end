class Api::V1::RecordsController < ApplicationController
  before_action :authenticate_request

  def stats
    total_records = 2847 # Placeholder or count from a table if we had one for generic records
    expiring_soon = 124  # Placeholder
    storage_used = 2.4   # TB, Placeholder
    
    render json: {
      total_records: total_records,
      expiring_records: expiring_soon,
      storage_used: storage_used,
      retention_policies_count: RetentionPolicy.count,
      legal_holds_count: LegalHold.where(status: 'active').count
    }
  end

  def audit_logs
    @logs = ActivityLog.all.order(created_at: :desc).limit(100)
    render json: @logs
  end

  # Retention Policies
  def retention_policies
    @policies = RetentionPolicy.all.order(created_at: :desc)
    render json: @policies
  end

  def create_retention_policy
    @policy = RetentionPolicy.new(retention_policy_params)
    @policy.user = current_user
    if @policy.save
      render json: @policy, status: :created
    else
      render json: { errors: @policy.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Legal Holds
  def legal_holds
    @holds = LegalHold.all.order(created_at: :desc)
    render json: @holds
  end

  def create_legal_hold
    @hold = LegalHold.new(legal_hold_params)
    @hold.user = current_user
    if @hold.save
      render json: @hold, status: :created
    else
      render json: { errors: @hold.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def retention_policy_params
    params.require(:retention_policy).permit(:title, :description, :duration_months, :is_active)
  end

  def legal_hold_params
    params.require(:legal_hold).permit(:title, :description, :entity_type, :entity_id, :status)
  end
end
