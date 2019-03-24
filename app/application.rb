require 'sinatra' 
require 'json'    
require 'sinatra/reloader' if development?
require_relative './models/profile'

settings = JSON.parse(File.open("./config/settings.json","r").read())
set :environment, settings['dev'] ? :development : :production
set :method_override, true

get('') do
    redirect('/calories/1/home')
end

get('/') do
    redirect('/calories/1/home')
end

get('/calories/:id/home') do
    if !Profile.exists?()
        redirect('calories/welcome')
    end
    @profile = Profile.find(params['id'])
    erb(:"home/view")
end

get('/calories/welcome') do
    erb(:welcome)
end

get('/calories/profile/create') do
    erb(:"profile/create")
end

get('/calories/:id/profile') do
    @profile = Profile.find(params[:id])
    erb(:"profile/view")
end

get('/calories/:id/profile/edit') do
    @profile = Profile.find(params[:id])
    erb(:"profile/edit")
end

post('/calories/profile') do
    profile = Profile.new(params)
    profile.save()
    redirect("/calories/#{profile.id}/profile")
end

delete('/calories/:id/profile') do
    Profile.new(params).delete()
    redirect('')
end

patch('/calories/:id/profile') do
    Profile.find(params[:id]).update(params)
    puts "patch!"
    redirect("/calories/#{params[:id]}/profile")
end

