class API::V1::UsersController < API::BaseController
  skip_filter :authenticate

  respond_to :json

  def show
    @user = User.find(params[:id])
  end
end
