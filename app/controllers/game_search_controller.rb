class GameSearchController < ApplicationController
  def games
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      # games = Game.where("games.name like ?", like).limit(10).joins("LEFT JOIN systems ON systems.id = games.system_id").select("games.id, games.name, systems.name as system_name")
      games = Game.includes(:system).where("games.name like ?", like).limit(10)
    else
      games = Game.all
    end
    list = games.map {|u| Hash[ id: u.id, label: u.name + " (" + u.system.name + ")", name: u.name]}
    puts list
    render json: list
  end
end
