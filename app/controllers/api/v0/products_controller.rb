class API::V0::ProductsController < API::BaseController
  skip_filter :authenticate, only: [:index]
  before_action :disallow_guests, only: [:create]
  respond_to :json

  def index
    @products = Product.order(:name)
    render :index
  end

  def create
    @product = Product.where(type: params[:type], sku: params[:sku]).last || Product.new(product_params)

    if @product.persisted? || @product.save
      render :show
    else
      render json: { class: "product", errors: @product.errors }, status: :unprocessible_entity
    end
  end

  private

  def product_params
    params.permit(:type, :sku)
  end
end
