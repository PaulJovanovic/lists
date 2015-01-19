class HomeController < ApplicationController
  def index
    @categories = Category.all
    @lists = List.scope("most_popular")
  end
end
