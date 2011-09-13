class Confirmation
    include HTTParty
    format :xml
    # debug_output

    CONFIRMATION = <<XML
<confirmation>
  <activationcode>%s</activationcode>
</confirmation>
XML
    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        self.class.base_uri config['connection']['base_uri']
    end

    def confirm(confirmation)

        body = CONFIRMATION % [
            confirmation[:confirmation_code]
        ]
        options = {
            :headers => {'content-type', 'application/xml'},
            :body => body
        }
        # response = self.class.post('/rest/v1/registrations', options)
        # puts response.to_s
        puts 'Got it!!!'
    end

end