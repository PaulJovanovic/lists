class HomeController < ApplicationController
  def index
    @categories = Category.includes(:lists).where("lists_count > ?", 2).order(lists_count: :desc)
  end
end
