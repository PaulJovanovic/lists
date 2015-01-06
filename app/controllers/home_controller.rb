class HomeController < ApplicationController
  def index
    @lists = List.where("products_count > 0").order(products_count: :desc)
  end
end
