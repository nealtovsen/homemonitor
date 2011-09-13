class Registration
    include HTTParty
    include TWExceptions
    format :xml
    debug_output

    REGISTRATION = <<XML
<registration>
  <tenantname>%s</tenantname>
  <tenantcode>%s</tenantcode>
  <ownerusername>%s</ownerusername>
  <initialpassword>%s</initialpassword>
  <owneremail>%s</owneremail>
  <templatecode>TWBasic</templatecode>
  <ownerfirstname>%s</ownerfirstname>
  <ownerlastname>%s</ownerlastname>
</registration>
XML

    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        self.class.base_uri config['connection']['base_uri']
    end

    def register(registration)
        body = REGISTRATION % [
            registration[:organization_name],
            registration[:organization_code],
            registration[:username],
            registration[:password],
            registration[:email],
            registration[:first_name],
            registration[:last_name]
        ]
        options = {
            :headers => {'content-type', 'application/xml'},
            :body => body
        }
        response = self.class.post('/rest/v1/registrations', options)
        # puts "response"
        # puts response.response.code.to_yaml
        if response.response.code != '204'
          regException = TWRegFailed.new()
          regException.reason = response.response.body
          raise regException
        end
        
        return true
    end
    
end