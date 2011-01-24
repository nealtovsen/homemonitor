class Confirmation
    include HTTParty
    format :xml
    # debug_output

    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        self.class.base_uri config['connection']['base_uri']
    end

    def confirm(confirmation)
        body = CONFIRMATION % [
            confirmation[:activation_code]
        options = {
            :headers => {'content-type', 'application/xml'},
            :body => body
        }
        response = self.class.post('/rest/v1/confirmations', options)
        puts response.to_s
    end

    CONFIRMATION = <<XML
<confirmation>
  <activationcode>%s</activationcode>
</confirmation>
XML
end