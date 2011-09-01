require 'coffee_script'
require 'sinatra'
require 'haml'
require 'sass'

module Amp
  class Block < Sinatra::Base
    set :root, File.expand_path("../../..", __FILE__)
    set :scss, cache_location: "tmp/sass-cache", style: :compact

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
end
