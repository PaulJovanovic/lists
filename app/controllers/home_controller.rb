class HomeController < ApplicationController
  def index
    @categories = Category.order(current_score: :desc)
  end
end
