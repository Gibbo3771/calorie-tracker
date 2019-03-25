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

    attr_reader :id
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
    end

    public

    def calculate_bmr()
        return ((10 * @weight.to_f) + (6.25 * @height.to_f) - (5 * calculate_age().to_i) + (@gender == "male" ? 5 : -161)).to_i
    end

    def calculate_age()
        sql = "SELECT EXTRACT(YEAR FROM age(cast($1 as date)))"
        puts @date_of_birth
        return (SqlRunner.run(sql, [@date_of_birth]).map { |data| data['date_part']}).first()
    end

    def save()
        sql = "INSERT INTO #{self.class.table} (
            first_name, 
            last_name, 
            date_of_birth, 
            gender,
            height, 
            weight
            ) VALUES (
                $1, $2, to_date($3, 'YYYYMMDD'), $4, $5, $6
            ) RETURNING id"
        puts "table = #{table}"
        @id = (SqlRunner.run(sql, [@first_name, @last_name, @date_of_birth, @gender, @height, @weight]).map {|data| data['id']}).first()
    end

    def update(options)
        set_data(options)
        sql = "UPDATE #{self.class.table} SET
            first_name = $1, 
            last_name = $2, 
            date_of_birth = $3,
            gender = $4, 
            height = $5, 
            weight = $6
            WHERE id = $7"
        @id = SqlRunner.run(sql, [@first_name, @last_name, @date_of_birth, @gender, @height, @weight, @id])    
    end

end