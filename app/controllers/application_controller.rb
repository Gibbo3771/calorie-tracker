require 'sinatra'
require_relative '../../helpers/helpers'
require_relative '../models/profile'

class ApplicationController < Sinatra::Base
    include Sinatra::Nom::SessionHelper
    register Sinatra::Nom::SessionHelper

    settings = JSON.parse(File.open("./config/settings.json","r").read())
    set :views, File.expand_path('../../views', __FILE__)
    set :public_dir, File.expand_path('../../public', __FILE__)
    set :environment, settings['dev'] ? :development : :production
    set :method_override, true

    enable :sessions
    
    get('/') do
        activate_profile(Profile.find_first())
        redirect('/welcome') unless profile_active?()
        redirect("track/#{session[:profile_id]}")
    end

    get('/welcome') do
        redirect("/track/#{session[:profile_id]}") if profile_active?()
        erb(:welcome)
    end

end