class CommentsController < ApplicationController
  def create
  	comment = Comment.new(params[:comment])

  	if comment.save
  		redirect_to game_path(params[:comment][:game_id])
  	else
  		redirect_to game_path(params[:comment][:game_id])
  	end
  end

  def destroy
    comment = Comment.find(params[:id])

    comment.destroy
    redirect_to :back
  end
end
