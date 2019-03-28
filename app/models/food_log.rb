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

        def delete_most_recent()
            sql = "SELECT * FROM #{table}
            ORDER BY id DESC
            LIMIT 1"
            recent = (SqlRunner.run(sql).map { |data| create_instance(data)}).first()
            recent.delete() if recent
        end
        
    end

    # protected
    
    attr_accessor :profile_id, :food_id, :calories, :datestamp, :timestamp, :weight
    def set_data(options)
        super
        @profile_id = options['profile_id']
        @food_id = options['food_id']
        @calories = options['calories']
        @datestamp = options['datestamp']
        @timestamp = options['timestamp']
        @weight = options['weight']
    end

    public

    def save()
        sql = "INSERT INTO #{self.class.table} (
            profile_id,
            food_id,
            calories,
            datestamp,
            timestamp,
            weight
            ) VALUES (
             $1,
             $2,
             $3,
             CURRENT_DATE,
             localtime(0),
             $4  
            ) RETURNING id"
        @id = SqlRunner.run(sql, [@profile_id, @food_id, @calories, @weight]).map {|i| i['id']}
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

    def to_s
        food = get_food()
        return "#{food.food_name} (#{@weight}g) (#{@calories}kcal)"
    end

end