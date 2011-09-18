class Confirmation
    include HTTParty
    include TWExceptions
    format :xml
    debug_output

    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        self.class.base_uri config['connection']['base_uri']
    end

    def confirm(confirmation, current_user)
        if current_user.nil?
            Rails.logger.info("current_user is nil")
            raise TWSessionEnded
        end
        
        body = CONFIRMATION % [
            confirmation[:confirmation_code]
        ]
        options = { 
          :cookies => {:JSESSIONID => current_user.session_id}, 
          :headers => {'content-type' => 'application/xml'},
          :body => body 
        }
        response = self.class.post('/rest/v1/confirmations', options)
        puts response.to_s
        puts 'Got it!!!'
    end

    CONFIRMATION = <<XML
<confirmation>
  <activationcode>%s</activationcode>
</confirmation>
XML
end