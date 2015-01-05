class HomeController < ApplicationController
  def index
    @lists = List.order(products_count: :desc)
  end
end
