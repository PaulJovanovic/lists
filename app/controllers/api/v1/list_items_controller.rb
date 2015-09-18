class API::V1::ListItemsController < API::BaseController

  skip_filter :authenticate
  respond_to :json

  def show
    @list_item = ListItem.find(params[:id])
  end
end
