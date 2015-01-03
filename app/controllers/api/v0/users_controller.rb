class API::V0::UsersController < API::BaseController

  respond_to :json

  def show

  end

  def like
    likable = params[:likable_type].constantize.find(params[:likable_id])
    if likable && current_user.like(likable)
      @like = current_user.likes.where(likable_type: params[:likable_type], likable_id: params[:likable_id]).last
      render "api/v0/likes/show"
    else
      render json: { class: "like", errors: likable.errors }, status: :unprocessable_entity
    end
  end

  def unlike
    likable = params[:likable_type].constantize.find(params[:likable_id])
    if !likable || current_user.unlike(likable)
      render json: { status: 200 }
    else
      render json: { class: "like", errors: likable.errors }, status: :unprocessable_entity
    end
  end
end
