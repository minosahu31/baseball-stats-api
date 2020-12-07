# Contoller to for players CRUD
class PlayersController < ApplicationController
  def index
    players = params[:page].present? ? Player.page(params[:page]).order("created_at DESC") : Player.all

    render json: { success: true, players: players.select(:id, :given_name, :avg, :home_runs, :runs, :ops), totalItems: Player.count }
  end
end
