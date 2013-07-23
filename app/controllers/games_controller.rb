class GamesController < ApplicationController
  autocomplete :game, :name
  
  def index
    @page_title = "EXPLORE GAMES"
  end

  def new
    @page_title = "NEW GAME"
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
  end
  
  def create
    game = Game.new(params[:game])
    
    if game.save
      redirect_to game_path(game.id)
    else
      render "new"
    end
  end

  def preview
    puts "this is the preview method!"

    @game = Game.find(params[:timeline_event][:game_id])

    puts @game.name

    redirect_to game_path(@game.id)

  end
end
