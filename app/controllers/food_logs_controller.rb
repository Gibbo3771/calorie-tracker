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
        require_active_profile!()
        @profile = Profile.find(params['id'])
        @foods = Food.all()
        @food_logs = @profile.get_food_log_all().reverse()
        @food_logs_today = @profile.get_food_logs_today()
        @row_no = 1
        erb(:"track/view")
    end

    post('/add-food') do
        food_log = FoodLog.new(params)
        food = Food.new(params).save()
        food_log.set_food(food)
        food_log.save()
        redirect("/track/#{params[session[:profile_id]]}")
    end

    post('/quick-add') do
        food_log = FoodLog.find_by_pretty_name(params[:pretty_food_name])
        food_log.save()
        redirect("/track/#{params[session[:profile_id]]}")
    end

    delete('/:id') do
        FoodLog.find(params[:id]).delete()
        redirect("/track/#{session[:profile_id]}")
    end

end