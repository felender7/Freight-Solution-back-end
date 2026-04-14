module Authentication
  extend ActiveSupport::Concern

  def authenticate_request
    token = extract_token
    return render_unauthorized("Missing token") if token.nil?

    payload = JsonWebToken.decode(token)
    return render_unauthorized("Invalid token") if payload.nil?

    @current_user = User.find_by(id: payload[:sub])
    render_unauthorized("User not found") if @current_user.nil?
  end

  def current_user
    @current_user
  end

  private

  def extract_token
    header = request.headers["Authorization"]
    return nil if header.nil?

    header.split(" ").last if header.start_with?("Bearer ")
  end

  def render_unauthorized(message)
    render json: { message: message }, status: :unauthorized
  end
end
