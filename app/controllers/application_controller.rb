require 'sinatra'

class ApplicationController < Sinatra::Base

    settings = JSON.parse(File.open("./config/settings.json","r").read())
    set :views, File.expand_path('../../views', __FILE__)
    set :environment, settings['dev'] ? :development : :production
    set :method_override, true

end