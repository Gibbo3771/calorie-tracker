require_relative './model'

class FoodLog < Model
    class << self

        def table
            "food_logs"
        end

        def create_instance(options)
            return FoodLog.new(options)
        end

        def find_by_pretty_name(name)
            all = all()
            for food_log in all
                return food_log if food_log.to_s == name
            end
        end

        def all_distinct_by_pretty_name()
            sql = "SELECT DISTINCT ON (pretty_name) * FROM food_logs"
        return (SqlRunner.run(sql, []).map {|data| Food.new(data)})
        end

        def group_by_meal_time(logs)
            l = Array.new(logs)
            meal_times = MealTime.all()
            l.sort_by { |mt| meal_times.index mt.id }
            return l.reverse()
        end

        def delete_most_recent()
            sql = "SELECT * FROM #{table}
            ORDER BY id DESC
            LIMIT 1"
            recent = (SqlRunner.run(sql).map { |data| create_instance(data)}).first()
            recent.delete() if recent
        end
        
    end

    # protected
    
    attr_accessor :profile_id, :food_id, :calories, :datestamp, :timestamp, :weight, :meal_time_id
    def set_data(options)
        super
        @profile_id = options['profile_id']
        @food_id = options['food_id']
        @calories = options['calories']
        @datestamp = options['datestamp']
        @timestamp = options['timestamp']
        @weight = options['weight']
        @meal_time_id = options['meal_time_id']
    end

    public

    def save()
        sql = "INSERT INTO #{self.class.table} (
            profile_id,
            food_id,
            meal_time_id,
            calories,
            datestamp,
            timestamp,
            weight,
            pretty_name
            ) VALUES (
             $1,
             $2,
             $3,
             $4,
             CURRENT_DATE,
             localtime(0),
             $5,
             $6  
            ) RETURNING id"
        @id = SqlRunner.run(sql, [@profile_id, @food_id, @meal_time_id, @calories, @weight, self.to_s()]).map {|i| i['id']}
        return
    end

    def get_food()
        sql = "SELECT * FROM foods
        WHERE id = $1"
        return (SqlRunner.run(sql, [@food_id]).map {|data| Food.new(data)}).first()
    end

    def set_food(food)
        @food_id = food.id
    end

    def set_meal_time(meal_time)
        @meal_time_id = meal_time.id
    end

    def get_meal_time()
        sql = "SELECT * FROM meal_times
        WHERE id = $1"
        return (SqlRunner.run(sql, [@meal_time_id]).map {|data| MealTime.new(data)}).first()
    end

    def to_s
        food = get_food()
        return "#{food.food_name} (#{@weight}g) (#{@calories}kcal)"
    end

end