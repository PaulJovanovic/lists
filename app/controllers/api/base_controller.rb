class API::BaseController < ActionController::Base

  attr_accessor :current_user
  before_filter :authenticate

private
  def authenticate
    if user = user_from_api_token
      @current_user = user
    else
      render json: { status: 'Unauthorized' }, status: :unauthorized
    end
  end

  def disallow_guests
    if user_from_api_token.guest?
      render json: { status: 'Unauthorized' }, status: :unauthorized
    end
  end

  def set_response_authentication_credentials(user)
    response.headers["X-Lists-Authentication-Credentials"] = (user.api_token || user.generate_api_token)
  end

  def user_from_api_token
    if token = extract_api_token.presence
      User.find_by_api_token(token)
    end
  end

  def extract_api_token
    ActionController::HttpAuthentication::Basic.user_name_and_password(request).first
  rescue NoMethodError
    request.headers["X-Lists-Api-Token"]
  end
end
