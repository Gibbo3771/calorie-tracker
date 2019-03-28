require_relative './application_controller'
require_relative '../models/profile'

class SessionsController < ApplicationController

    get('/try') do
        profile = Profile.find_first()
        activate_profile(profile) if profile_exists?(profile)
        redirect('/profile/create') unless profile_active?()
        redirect("track/#{profile.id}")
    end

end