require 'sinatra'
require_relative 'lib/tower_of_hanoi'

enable :sessions

helpers do
  def set_session(game)
    session['towers'] = game.towers
  end

  def load_session
    towers = session[:towers]
  end
end  

get '/' do
  error = nil
  tower = TowerOfHanoi.new
  set_session(tower)
  erb :game, :locals => {:tower => tower, :error => error}
end

post '/' do
  error = "Invalid move"
  gamestate = load_session
  tower = TowerOfHanoi.new(gamestate)
  if tower.valid_move?(params[:from].to_i, params[:to].to_i)
    tower.move(params[:from].to_i, params[:to].to_i)
    error = nil
  end
  set_session(tower)

  erb :game, :locals => {:tower => tower, :error => error}
end