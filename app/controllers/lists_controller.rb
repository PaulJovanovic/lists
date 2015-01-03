class ListsController < ApplicationController
  def index
    @lists = List.all.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end
end
