class HomeController < ApplicationController
  def index
    @lists = List.all
  end
end
