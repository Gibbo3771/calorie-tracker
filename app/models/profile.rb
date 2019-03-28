require 'date'
require_relative './model'

class Profile < Model
    class << self

        def table
            "profiles"
        end

        def create_instance(options)
            return Profile.new(options)
        end

        def find_first()
            sql = "SELECT * FROM #{table}"
            return (SqlRunner.run(sql).map {|data| Profile.new(data)}).first()
        end

        def exists?()
            sql = "SELECT COUNT(*) FROM #{table}"
            count = SqlRunner.run(sql).map {|data| data['count']}
            return count.first.to_i == 1
        end
    end

    attr_reader :id, :physical_activity_level_id
    attr_accessor :first_name, :last_name, :date_of_birth, :height, :weight

    protected

    def set_data(options)
        super
        @first_name = options['first_name']
        @last_name = options['last_name']
        @date_of_birth = options['date_of_birth']
        @gender = options['gender']
        @height = options['height']
        @weight = options['weight']
        @physical_activity_level_id = options['physical_activity_level_id']
    end

    public

    def calculate_bmr()
        return ((10 * @weight.to_f) + (6.25 * @height.to_f) - (5 * calculate_age().to_i) + (@gender == "male" ? 5 : -161)).to_i
    end

    def physical_activity_level()
        sql = "SELECT * FROM physical_activity_levels
        WHERE id = $1"
        return (SqlRunner.run(sql, [@physical_activity_level_id]).map {|data| PhysicalActivityLevel.new(data)}).first()
    end

    def calories_consumed_today()
        sql = "SELECT SUM(food_logs.calories) AS total FROM food_logs
        WHERE 
        food_logs.profile_id = $1 
        AND 
        date_part('day', food_logs.datestamp) - date_part('day', CURRENT_DATE) = 0"
        return (SqlRunner.run(sql, [@id]).map {|data| data['total']}).first().to_i
    end

    def get_food_logs_today()
        sql = "SELECT * FROM food_logs
        WHERE food_logs.profile_id = $1
        AND
        date_part('day', food_logs.datestamp) - date_part('day', CURRENT_DATE) = 0
        ORDER BY id DESC"
        return (SqlRunner.run(sql, [@id]).map { |data| FoodLog.new(data)})
    end

    def get_food_log_all()
        sql = "SELECT * FROM food_logs
        WHERE food_logs.profile_id = $1"
        return (SqlRunner.run(sql, [@id]).map { |data| FoodLog.new(data)})
    end

    def remaining_calories()
        return ((calculate_bmr() * physical_activity_level().bmr_multiplier) - calories_consumed_today()).to_i
    end

    def calculate_age()
        sql = "SELECT EXTRACT(YEAR FROM age(cast($1 as date)))"
        return (SqlRunner.run(sql, [@date_of_birth]).map { |data| data['date_part']}).first()
    end

    def save()
        puts @date_of_birth
        sql = "INSERT INTO #{self.class.table} (
            first_name, 
            last_name, 
            date_of_birth, 
            gender,
            height, 
            weight,
            physical_activity_level_id
            ) VALUES (
                $1, $2, to_date($3, 'YYYYMMDD'), $4, $5, $6, $7
            ) RETURNING id"
        @id = (SqlRunner.run(sql, [@first_name, @last_name, @date_of_birth, @gender, @height, @weight, @physical_activity_level_id]).map {|data| data['id']}).first()
    end

    def update(options)
        set_data(options)
        sql = "UPDATE #{self.class.table} SET
            first_name = $1, 
            last_name = $2, 
            date_of_birth = $3,
            gender = $4, 
            height = $5, 
            weight = $6,
            physical_activity_level_id = $7
            WHERE id = $8"
        @id = SqlRunner.run(sql, [@first_name, @last_name, @date_of_birth, @gender, @height, @weight, @physical_activity_level_id, @id])    
    end

end