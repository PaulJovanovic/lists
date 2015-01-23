class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @lists = @category.lists.order(total_score: :desc)
  end
end
