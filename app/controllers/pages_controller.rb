class PagesController < ApplicationController
    # require "googleVisualr"

    # def home
    #     @title = "Home"
    #     if signed_in?
    #         @observations = Observation.new.get_recent("homemonitor")
    #         annotated_time_line
    #     end
    # end

    def contact
        @title = "Contact"
    end

    def about
        @title = "About"
    end

    def help
        @title = "Help"
    end

    def home
        @title = "Home"
        if signed_in?
            # @observations = Observation.new.get_recent("homemonitor")
            # 
            # @chart = GoogleVisualr::AnnotatedTimeLine.new
            # @chart.add_column('date' , 'Date')
            # @chart.add_column('number', 'Temp F')
            # @chart.add_column('number', 'Light' )
            # 
            # unless @observations.nil?
            #     @observations.each do |observation|
            #     # puts observation
            #         date = Time.iso8601(observation["samplingTime"])
            #         result = observation["result"]["record"]["quantity"]
            #         @chart.add_row([date, result[0]["value"].to_f, result[1]["value"].to_f])
            #     end
            # 
            #     options = { :displayAnnotations => true, :scaleType => 'allfixed', :scaleColumns => [0,1], :displayZoomButtons => false }
            #     options.each_pair do | key, value |
            #         @chart.send "#{key}=", value
            #     end
            # end
        end
    end
end
