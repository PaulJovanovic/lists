class API::V0::ListsController < API::BaseController
  skip_filter :authenticate, only: [:show, :index]
  respond_to :json

  def index
    @lists = List.scope(params[:scope], params[:scope_params])
    render :index
  end

  def show
    @list = List.find(params[:id])
    render :show
  end

  def create
    @list = List.new(list_params.merge({user: current_user}))

    if @list.save
      render :show
    else
      render json: { class: "list", errors: @list.errors }, status: :unprocessable_entity
    end
  end

  def add_product
    @list = List.find(params[:id])
    @product = Product.find(params[:product_id])

    if @item = @list.add_product(@product, current_user)
      render :add_product
    else
      render json: { class: "list", errors: @list.errors}, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.permit(:name)
  end
end
