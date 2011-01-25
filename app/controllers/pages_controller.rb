class PagesController < ApplicationController

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
        puts "signed_in: " + signed_in?.to_s
        if signed_in?
            @observations = Observation.new.get_recent("homemonitor", 500, @current_user["orgcode"], @current_user["username"], @current_user["password"])
            # @observations = Observation.new.get_recent("tempsensor1")
            # puts "COUNTING OBSERVATIONS: " + @observations.count.to_s
            data = GoogleVisualr::DataTable::DataTable.new

            # Add Column Headers

            # date
            data.add_column('date', 'Date')
            # temp value
            data.add_column('number', 'Temp F')
            # temp annotation title
            data.add_column('string', 'title1')
            # temp annotation value
            data.add_column('string', 'text1')
            # light value
            data.add_column('number', 'Light')
            # light annotation title
            data.add_column('string', 'title2')
            # light annotation value
            data.add_column('string', 'text2')

            # Add Rows and Values
            data.add_rows(@observations.count)

            unless @observations.nil?
                index = 0
                @observations.each do |observation|
                    date = Time.iso8601(observation["samplingTime"])
                    temp = observation["result"]["record"]["quantity"][0]["value"].to_f
                    light = observation["result"]["record"]["quantity"][1]["value"].to_f
                    data.set_value(index, 0, date)
                    data.set_value(index, 1, temp)
                    data.set_value(index, 4, light)
                    index = index + 1
                end
            end

            post_options = { :displayAnnotations => false, :scaleType => 'allfixed', :scaleColumns => [0,1], :displayZoomButtons => false }
        @chart = GoogleVisualr::Visualizations::AnnotatedTimeLine.new(post_options, data)
        end
    end
end
