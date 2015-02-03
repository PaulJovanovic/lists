class API::V0::ListItemsController < API::BaseController

  skip_filter :authenticate
  respond_to :json

  def show
    @list = List.find(params[:list_id])
    @list_item = @list.items.where(id: params[:id]).last
    render :show
  end
end
