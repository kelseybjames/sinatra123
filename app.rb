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
  tower.move(params[:from], params[:to])
  set_session(tower)
  tower = load_session

  erb :game, :locals => {:tower => tower}
end