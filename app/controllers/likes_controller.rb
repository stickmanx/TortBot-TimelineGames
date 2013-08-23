class LikesController < ApplicationController
  def create
  	like = Like.new(params[:like])

  	if like.save
  		redirect_to :back
  	else
  		redirect_to :back
  	end
  end

  def destroy
  	like = Like.where(params[:like]).first

  	like.destroy
  	redirect_to :back
  end
end
