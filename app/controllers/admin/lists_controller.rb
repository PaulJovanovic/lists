class Admin::ListsController < AdminController
  def index
    @lists = List.order(created_at: :desc).paginate(page: params[:page], per_page: 25)
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to admin_list_path(@list)
    else
      render :new
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])

    if @list.update_attributes(list_params)
      redirect_to admin_list_path(@list)
    else
      render :edit
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
