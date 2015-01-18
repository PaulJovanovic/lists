class HomeController < ApplicationController
  def index
    @categories = Category.all
    @lists = List.scope("most_active_by_category", @categories.first.name)
  end
end
