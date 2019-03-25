require_relative '../models/profile'
require_relative '../models/physical_activity_level'
require_relative './application_controller'

class ProfilesController < ApplicationController

    get('/create') do
        @physical_activity_levels = PhysicalActivityLevel.all()
        puts @physical_activity_levels
        erb(:"profile/create")
    end
    
    get('/:id') do
        @profile = Profile.find(params[:id])
        erb(:"profile/view")
    end
    
    get('/:id/edit') do
        @profile = Profile.find(params[:id])
        erb(:"profile/edit")
    end
    
    post('/') do
        profile = Profile.new(params)
        profile.save()
        redirect("/home/#{profile.id}")
    end
    
    delete('/:id') do
        Profile.new(params).delete()
        redirect('/welcome')
    end
    
    patch('/:id') do
        Profile.find(params[:id]).update(params)
        redirect("/profile/#{params[:id]}")
    end

end