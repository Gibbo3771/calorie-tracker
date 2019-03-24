require_relative '../models/profile'
require_relative './application_controller'

class WelcomeController < ApplicationController
    
    get('') do
        if Profile.exists?()
            redirect('profile/1')
        end
        erb(:welcome)
    end
    
    get('/home/:id') do
        @profile = Profile.find(params['id'])
        erb(:"home/view")
    end

end