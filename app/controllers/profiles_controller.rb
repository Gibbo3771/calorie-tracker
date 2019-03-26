require_relative '../models/profile'
require_relative '../models/physical_activity_level'
require_relative './application_controller'

class ProfilesController < ApplicationController

    get('/') do
        if Profile.exists?()
            profile = Profile.find_first()
            redirect("/profile/#{profile.id}")
        end
        redirect("/calories/welcome")
    end

    get('/create') do
        @physical_activity_levels = PhysicalActivityLevel.all()
        erb(:"profile/create")
    end
    
    get('/:id') do
        @profile = Profile.find(params[:id])
        erb(:"profile/view")
    end
    
    get('/:id/edit') do
        @profile = Profile.find(params[:id])
        @physical_activity_levels = PhysicalActivityLevel.all()
        erb(:"profile/edit")
    end
    
    post('/') do
        profile = Profile.new(params)
        profile.save()
        redirect("/calories/#{profile.id}")
    end
    
    delete('/:id') do
        Profile.new(params).delete()
        redirect('/')
    end
    
    patch('/:id') do
        puts params
        Profile.find(params[:id]).update(params)
        redirect("/profile/#{params[:id]}")
    end

end