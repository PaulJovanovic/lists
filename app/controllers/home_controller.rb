class HomeController < ApplicationController
  def index
    @lists = List.scope("most_popular")
  end
end
