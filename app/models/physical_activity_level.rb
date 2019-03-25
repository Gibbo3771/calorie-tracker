require_relative './model'

class PhysicalActivityLevel < Model
    class << self
    
        def table
            "physical_activity_levels"
        end
    
        def create_instance(options)
            return PhysicalActivityLevel.new(options)
        end
    end

    attr_accessor :physical_activity_level, :descriptor, :bmr_multiplier

    def set_data(options)
        @physical_activity_level = options['physical_activity_level']
        @descriptor = options['descriptor']
        @bmr_multiplier = options['bmr_multiplier']
    end

    def to_s
        return "#{@physical_activity_level} - #{@descriptor}"
    end
end