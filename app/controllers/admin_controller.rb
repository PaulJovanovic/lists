class AdminController < ActionController::Base
  before_action :authenticate_user!
  before_action :authorize

  def authorize
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
