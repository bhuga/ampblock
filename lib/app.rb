require 'sinatra'
require 'haml'
require 'sass'

class AmpBlock < Sinatra::Base
  set :public, './public'
  
  get '/' do
    haml :index
  end

  get '/stylesheet.css' do
    scss :stylesheet
  end

  get '/ampblock.js' do
    coffee :ampblock
  end
end
