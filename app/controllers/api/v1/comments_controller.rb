class API::V1::CommentsController < API::BaseController
  skip_filter :authenticate

  respond_to :json

  def show
    @comment = Comment.find(params[:id])
  end

end
