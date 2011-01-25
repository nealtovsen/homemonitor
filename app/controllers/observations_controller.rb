class ObservationsController < ApplicationController
    before_filter :authenticate

    def show
        @observations = Observation.new.get_recent("tempsensor1")
    end


end
