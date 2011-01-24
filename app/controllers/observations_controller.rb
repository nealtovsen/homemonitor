class ObservationsController < ApplicationController
    before_filter :authenticate

    def show
        @observations = Observation.new.get_recent("homemonitor")
    end


end
