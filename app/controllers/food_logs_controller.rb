require_relative './application_controller'
require_relative '../models/food_log'
require_relative '../models/food'
require_relative '../models/profile'

class FoodLogsController < ApplicationController

    get("/") do
        require_active_profile!()
        redirect("/track/#{session[:profile_id]}")
    end

    get('/:id') do
        @profile = Profile.find(params['id'])
        @foods = Food.all()
        @food_log = @profile.get_food_log_today()
        erb(:"track/view")
    end

    post('/') do
        food_log = FoodLog.new(params)
        food = Food.new(params).save()
        food_log.set_food(food)
        food_log.save()
        redirect("/track/#{params['profile_id']}")
    end

    delete('/') do
        FoodLog.delete_most_recent()
        redirect("/track/#{params['id']}")
    end

end