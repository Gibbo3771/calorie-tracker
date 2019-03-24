require 'sinatra' 
require 'json'    
require 'sinatra/reloader' if development?
require_relative './models/profile'

settings = JSON.parse(File.open("./config/settings.json","r").read())
set :environment, settings['dev'] ? :development : :production
set :method_override, true

get('') do
    redirect('/calories/welcome')
end

get('/calories/welcome') do
    if Profile.exists?()
        redirect('calories/1/home')
    end
    erb(:welcome)
end

get('/calories/:id/home') do
    if !Profile.exists?()
        redirect('calories/welcome')
    end
    @profile = Profile.find(params['id'])
    erb(:"home/view")
end




