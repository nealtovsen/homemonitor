class Observation
    include HTTParty
    include TWExceptions
    format :xml
    debug_output

    attr_accessor :samplingtime, :id, :light, :temp, :sensorProcess

    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        self.class.base_uri config['connection']['base_uri']
    end

    def get_recent(sensorName, pagesize, current_user)
        if current_user.nil?
            Rails.logger.info("current_user is nil")
            raise TWSessionEnded
        end

        # observations = self.class.get('/rest/v1/observations/neal1?sensor=tempsensor1&begin=2010-11-11', options)
        #options = { :query => {:begin => 5.days.ago.iso8601, :sensor => sensorName} }
        options = { :cookies => {:JSESSIONID => current_user.session_id}, :query => {:pagesize => pagesize, :sensor => sensorName} }
        begin
            response = self.class.get('/rest/v1/observations/' + current_user.orgcode, options)
            
            if response.response.code == '403'
              raise TWNotAllowed
            end

            observations = Array.new
            unless response["observations"].nil?
                resp_obs_list = response["observations"]["observation"]
                unless resp_obs_list.nil?
                  unless resp_obs_list.is_a?(Array)
                    resp_obs_list = [response["observations"]["observation"]]
                  end
                  resp_obs_list.each do |resp_obs|
                    observation = Observation.new()
                    observation.id = resp_obs["id"]
                    observation.samplingtime = resp_obs["samplingTime"]
                    observation.temp = resp_obs["result"]["record"]["quantity"][0]["value"]
                    observation.light = resp_obs["result"]["record"]["quantity"][1]["value"]
                    observation.sensorProcess = resp_obs["sensorProcess"]
                    observations << observation
                  end
                end
            end
            return observations
            
        end
    end

end
