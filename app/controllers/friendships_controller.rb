class FriendshipsController < ApplicationController
  def index
    
  	@users = User.where("id !="+current_user.id.to_s).all
  	@friendships = current_user.friendships
  end

  def create
  	friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  	if friendship.save
  		flash[:notice] = "Added friend"
  		redirect_to friendships_path
  	else
  		flash[:error] = "Unable to add friend"
  		redirect_to friendships_path
  	end
  end

  def destroy
  	friendship = current_user.friendships.find(params[:id])
  	friendship.destroy
  	flash[:notice] = "Remove friendship"
  	redirect_to friendships_path
  end

  def show

  end
end
