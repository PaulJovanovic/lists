class HomeController < ApplicationController
  def index
    @categories = Category.includes(:lists).where("lists_count > ?", 1).order(lists_count: :desc)
  end
end
