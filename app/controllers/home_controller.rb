class HomeController < ApplicationController
  def index
    @categories = Category.includes(:lists).order(current_score: :desc)
  end
end
