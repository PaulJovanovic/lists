class HomeController < ApplicationController
  def index
    @categories = Category.all
    @lists = List.scope("all")
  end
end
