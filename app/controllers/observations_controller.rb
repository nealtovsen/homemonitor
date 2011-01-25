class ObservationsController < ApplicationController
    before_filter :authenticate

    def show
        puts "USER INFO: " + @current_user.to_s
        @observations = Observation.new.get_recent("homemonitor", 50, @current_user["orgcode"], @current_user["username"], @current_user["password"])
    end

end
