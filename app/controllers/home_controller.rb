class HomeController < ApplicationController
  def index
    @lists = List.all.order(products_count: :desc)
  end
end
