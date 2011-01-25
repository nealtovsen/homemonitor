class PagesController < ApplicationController
    # require "GoogleVisualr"

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

    def home_old
        @title = "Home"
        # if signed_in?
        #@observations = Observation.new.get_recent("homemonitor")
        @observations = Observation.new.get_recent("tempsensor1")
        puts "COUNTING OBSERVATIONS: " + @observations.count.to_s

        @chart = GoogleVisualr::Visualizations::AnnotatedTimeLine.new
        @chart.add_columns('date' , 'Date')
        @chart.add_column('number', 'Temp F')
        # @chart.add_column('number', 'Light' )

        @observations.each do |observation|
        # puts observation
            date = Time.iso8601(observation["samplingTime"])
            result = observation["result"]["quantity"]
            @chart.add_row( [date, result["value"].to_f] )
        end

        options = { :displayAnnotations => true, :scaleType => 'allfixed', :scaleColumns => [0,1], :displayZoomButtons => false }

        options.each_pair do | key, value |
            @chart.send "#{key}=", value
        end

    end

    # def home
    #     @title = "Home"
    #     # if signed_in?
    #     #@observations = Observation.new.get_recent("homemonitor")
    #     @observations = Observation.new.get_recent("tempsensor1")
    #     puts "COUNTING OBSERVATIONS: " + @observations.count.to_s
    #     data = GoogleVisualr::DataTable::DataTable.new
    #
    #     # Add Column Headers
    #     data.add_column('string', 'Year' )
    #     data.add_column('number', 'Sales')
    #     data.add_column('number', 'Expenses')
    #
    #     # Add Rows and Values
    #     data.add_rows(4)
    #     data.set_value(0, 0, '2004')
    #     data.set_value(0, 1, 1000)
    #     data.set_value(0, 2, 400)
    #     data.set_value(1, 0, '2005')
    #     data.set_value(1, 1, 1170)
    #     data.set_value(1, 2, 460)
    #     data.set_value(2, 0, '2006')
    #     data.set_value(2, 1, 1500)
    #     data.set_value(2, 2, 660)
    #     data.set_value(3, 0, '2007')
    #     data.set_value(3, 1, 1030)
    #     data.set_value(3, 2, 540)
    #
    #     # data.add_column('date' , 'Date')
    #     # data.add_column('number', 'Temp F')
    #     # data.add_column('number', 'Light' )
    #
    #     # data.add_rows(@observations.count)
    #     #
    #     # index = 0
    #     # # unless @observations.nil?
    #     # @observations.each do |observation|
    #     # # puts observation
    #     #     date = Time.iso8601(observation["samplingTime"])
    #     #     # result = observation["result"]["record"]["quantity"]
    #     #     # @chart.add_row([date, result[0]["value"].to_f, result[1]["value"].to_f])
    #     #     # data.set_value([date, result[0]["value"].to_f])
    #     #     # data.set_value(date, 1, 2)
    #     #     result = observation["result"]["quantity"]
    #     #     data.set_value(index, date, result["value"].to_f)
    #     #     index = index + 1
    #     # end
    #     # end
    #
    #     options = { :displayAnnotations => true, :scaleType => 'allfixed', :scaleColumns => [0,1], :displayZoomButtons => false }
    #
    #     # @chart = GoogleVisualr::AnnotatedTimeLine.new
    #     @chart = GoogleVisualr::Visualizations::AnnotatedTimeLine.new(options, data)
    #
    # # options.each_pair do | key, value |
    # #     @chart.send "#{key}=", value
    # # end
    #
    # # end
    # end

    def home
        @title = "Home"
        # if signed_in?
        #@observations = Observation.new.get_recent("homemonitor")
        @observations = Observation.new.get_recent("tempsensor1")
        puts "COUNTING OBSERVATIONS: " + @observations.count.to_s
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
                result = observation["result"]["quantity"]["value"].to_f
                data.set_value(index, 0, date)
                data.set_value(index, 1, result)
                data.set_value(index, 4, 0)
                index = index + 1
            end
        end

        options = { :displayAnnotations => false, :scaleType => 'allfixed', :scaleColumns => [0,1], :displayZoomButtons => false }
        @chart = GoogleVisualr::Visualizations::AnnotatedTimeLine.new(options, data)
    end
end
