require 'sinatra'

class ApplicationController < Sinatra::Base

    settings = JSON.parse(File.open("./config/settings.json","r").read())
    set :views, File.expand_path('../../views', __FILE__)
    set :public_dir, File.expand_path('../../public', __FILE__)
    set :environment, settings['dev'] ? :development : :production
    set :method_override, true

    set :profile_id, "-1"

    @@profile_id = 5

    def logged_in?()
        return !@@profile_id.nil?
    end

    get('/') do
        redirect('/calories/welcome')
    end

end