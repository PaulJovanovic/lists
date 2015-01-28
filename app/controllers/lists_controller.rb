class ListsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @lists = List.all.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def empty
    @lists = List.needs_help
    render "index"
  end
end
