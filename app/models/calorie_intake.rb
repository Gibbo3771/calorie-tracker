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
    
    attr_accessor :profile_id, :calories, :datestamp
    def set_data(options)
        super
        @profile_id = options['profile_id']
        @calories = options['calories']
        @datestamp = options['datestamp']
    end

    public

    def save()
        sql = "INSERT INTO calorie_intakes (
            profile_id,
            calories,
            datestamp
            ) VALUES (
             $1,
             $2,
             CURRENT_DATE   
            ) RETURNING id"
        @id = SqlRunner.run(sql, [@profile_id, @calories]).map {|i| i['id']}
        return
    end

end