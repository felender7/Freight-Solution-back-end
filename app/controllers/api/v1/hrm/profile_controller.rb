class Api::V1::Hrm::ProfileController < Api::V1::Hrm::BaseController
  def show
    render json: current_employee.as_json(
      methods: [:full_name],
      include: {
        manager: { only: [:id, :first_name, :last_name] }
      }
    ).merge(
      profile_photo_url: current_employee.profile_photo.attached? ? url_for(current_employee.profile_photo) : nil,
      contract_url: current_employee.contract.attached? ? url_for(current_employee.contract) : nil,
      appointment_letter_url: current_employee.appointment_letter.attached? ? url_for(current_employee.appointment_letter) : nil
    )
  end

  def update
    if current_employee.update(profile_params)
      render json: { message: "Profile updated successfully" }
    else
      render json: { errors: current_employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:employee).permit(
      :first_name, :last_name, :phone,
      :address, :city, :state, :country, :zip_code,
      :education_background, :profile_photo
    )
  end
end
