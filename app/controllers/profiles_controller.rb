require_relative '../models/profile'
require_relative '../models/physical_activity_level'
require_relative './application_controller'

class ProfilesController < ApplicationController

    get('/create') do
        redirect('/') if profile_exists?(Profile.find_first())
        @physical_activity_levels = PhysicalActivityLevel.all()
        erb(:"profile/create")
    end
    
    get('/:id/edit') do
        @profile = Profile.find(params[:id])
        @physical_activity_levels = PhysicalActivityLevel.all()
        erb(:"profile/edit")
    end
    
    post('/') do
        profile = Profile.new(params)
        profile.save()
        activate_profile(profile)
        redirect("/calories/#{profile.id}")
    end
    
    delete('/:id') do
        profile = Profile.new(params)
        deactivate_profile()
        profile.delete()
        redirect('/')
    end
    
    patch('/:id') do
        puts params
        Profile.find(params[:id]).update(params)
        redirect("/calories/#{params[:id]}")
    end

end