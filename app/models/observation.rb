class Observation
    include HTTParty
    format :xml
    debug_output

    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        # @orgname = config["manufacturer"]["orgcode"]
        # admin = config["manufacturer"]["adminuser"]
        # username = @orgname + "\\" + admin
        # password = config["manufacturer"]["adminpassword"]

        self.class.base_uri config['connection']['base_uri']
        # self.class.basic_auth username, password
    end

    def get_recent(sensorName, pagesize, orgcode, username, submitted_password)
        # TODO: update this to get info from a security context
        
        login = orgcode + "\\" + username

        # observations = self.class.get('/rest/v1/observations/neal1?sensor=tempsensor1&begin=2010-11-11', options)
        #options = { :query => {:begin => 5.days.ago.iso8601, :sensor => sensorName} }
        options = { :basic_auth => {:username => login, :password => submitted_password}, :query => {:pagesize => pagesize, :sensor => sensorName} }
        begin
            response = self.class.get('/rest/v1/observations/' + orgcode, options)
            response["observations"]["observation"]
        rescue Exception => e
            puts "got exception!"
            puts e.message
        end
    end

end
