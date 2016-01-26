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
  tower = TowerOfHanoi.new
  set_session(tower)
  erb :game, :locals => {:tower => tower}
end

post '/' do
  gamestate = load_session
  tower = TowerOfHanoi.new(gamestate)
  if tower.valid_move?(params[:from].to_i, params[:to].to_i)
    tower.move(params[:from].to_i, params[:to].to_i)
  end
  set_session(tower)

  erb :game, :locals => {:tower => tower}
end