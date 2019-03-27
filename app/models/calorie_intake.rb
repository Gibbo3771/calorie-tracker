require_relative './model'

class CalorieIntake < Model
    class << self

        def table
            "calorie_intakes"
        end

        def create_instance(options)
            return CalorieIntake.new(options)
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
    
    attr_accessor :profile_id, :food_id, :calories, :datestamp, :timestamp
    def set_data(options)
        super
        @profile_id = options['profile_id']
        @food_id = options['food_id']
        @calories = options['calories']
        @datestamp = options['datestamp']
        @timestamp = options['timestamp']
    end

    public

    def save()
        sql = "INSERT INTO calorie_intakes (
            profile_id,
            food_id,
            calories,
            datestamp,
            timestamp
            ) VALUES (
             $1,
             $2,
             $3,
             CURRENT_DATE,
             localtime(0)   
            ) RETURNING id"
        @id = SqlRunner.run(sql, [@profile_id, @food_id, @calories]).map {|i| i['id']}
        return
    end

end