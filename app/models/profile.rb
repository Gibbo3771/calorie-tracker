require_relative './model'

class Profile < Model

    attr_reader :id
    attr_accessor :first_name, :last_name, :date_of_birth, :height, :weight

    def initialize(options, table="profiles")
        super
    end

    public

    def calculate_bmr()
        return (10 * @weight.to_f) + (6.25 * @height.to_f) - (5 * @age.to_i) + (@gender == "male" ? 5 : -161)
    end

    def self.exists?()
        sql = "SELECT COUNT(*) FROM profiles"
        count = SqlRunner.run(sql).map {|data| data['count']}
        return count.first.to_i == 1
    end

    def save()
        sql = "INSERT INTO #{table} (
            first_name, 
            last_name, 
            date_of_birth, 
            gender,
            height, 
            weight
            ) VALUES (
                $1, $2, to_date($3, 'YYYYMMDD'), $4, $5, $6
            ) RETURNING id"
        @id = (SqlRunner.run(sql, [@first_name, @last_name, @date_of_birth, @gender, @height, @weight]).map {|data| data['id']}).first()
    end

    def self.delete_all(table="profiles")
        super
    end

    def self.find(id, table="profiles")
        super
    end

    def self.all(table="profiles")
        super
    end

    def update(options)
        set_data(options)
        sql = "UPDATE #{table} SET
            first_name = $1, 
            last_name = $2, 
            date_of_birth = $3,
            gender = $4, 
            height = $5, 
            weight = $6
            WHERE id = $7"
        @id = SqlRunner.run(sql, [@first_name, @last_name, @date_of_birth, @gender, @height, @weight, @id])    
    end

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

    def self.create_instance(options)
        return Profile.new(options)
    end

end