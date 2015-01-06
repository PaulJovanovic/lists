class UsersController < ApplicationController
  def show
    @user = User.where(username: params[:username]).last
    @liked_items = ListItem.joins("JOIN likes ON likes.likable_id = list_items.id").last(3)
    @lists = Array.new
	@user.list_items.each do |list_item|  
		unless list_item.list.in? @lists   
	   		@lists << list_item.list
	   	end
	end
  end
end