class GameSearchController < ApplicationController
  def games
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      games = Game.where("name like ?", like)
    else
      games = Game.all
    end
    list = games.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    puts list
    render json: list
  end
end
