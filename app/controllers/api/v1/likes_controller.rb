class API::V1::LikesController < API::BaseController

  respond_to :json

  def create
    @like = Like.new(like_params.merge({user: current_user}))

    if @like.save
      render :show
    else
      render json: { class: "like", errors: @like.errors }, status: :unprocessable_entity
    end
  end

  def update
    @like = Like.find(params[:id])

    if @like.update_attributes(like_params)
      render :show
    else
      render json: { class: "like", errors: @like.errors }, status: :unprocessable_entity
    end
  end

  private

  def like_params
    params.permit(:likable_type, :likable_id, :active)
  end
end
