class Api::V1::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request, except: [ :login ]

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user.to_token_payload)
      render json: {
        token: token,
        user: {
          id: user.id,
          email: user.email,
          first_name: user.first_name,
          last_name: user.last_name,
          role: user.role,
          must_update_password: user.must_update_password
        }
      }
    else
      render json: { message: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    render json: { message: "Logged out successfully" }
  end

  def update_password
    if current_user.authenticate(params[:current_password])
      if current_user.update(password: params[:new_password], password_confirmation: params[:new_password_confirmation], must_update_password: false)
        render json: { message: "Password updated successfully" }
      else
        render json: { message: current_user.errors.full_messages.join(", ") }, status: :unprocessable_entity
      end
    else
      render json: { message: "Current password is incorrect" }, status: :unauthorized
    end
  end

  def me
    render json: {
      id: current_user.id,
      email: current_user.email,
      first_name: current_user.first_name,
      last_name: current_user.last_name,
      role: current_user.role,
      must_update_password: current_user.must_update_password,
      created_at: current_user.created_at
    }
  end
end
