class API::V1::StoresController < API::BaseController
  skip_filter :authenticate

  respond_to :json

  def search
    store = "#{params[:store]}Store".constantize.new
    @products = store.search(params[:q], params[:page])
    render "api/v0/stores/search"
  end
end
