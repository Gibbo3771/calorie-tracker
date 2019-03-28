require_relative './application_controller'
require_relative '../models/food_log'
require_relative '../models/food'
require_relative '../models/meal_time'
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
        @meal_times = MealTime.all()
        @row_no = 1
        @grouped_by = FoodLog.group_by_meal_time(@food_logs_today)
        for x in @grouped_by
            puts x.meal_time_id
        end
        erb(:"track/view")
    end

    post('/add-food') do
        food_log = FoodLog.new(params)
        food = Food.new(params).save()
        food_log.set_food(food)
        food_log.set_meal_time(MealTime.find_by_name(params[:meal_time]))
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