require_relative '../models/profile'
require_relative './application_controller'

class WelcomeController < ApplicationController
    
    # Needs cleaned up, perhaps write a profile helper
    get('') do
        if Profile.exists?()
            profile = Profile.find_first()
            redirect("profile/#{profile.id}")
        end
        erb(:welcome)
    end
    
    get('/home/:id') do
        @profile = Profile.find(params['id'])
        erb(:"home/view")
    end

end