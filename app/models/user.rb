class User
    include HTTParty
    format :xml
    debug_output

    def initialize
    end

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    def self.authenticate(orgcode, username, submitted_password)
      
        config = YAML.load_file("config/telemetryweb.yml")
        # self.class.base_uri config['connection']['base_uri']
        tw_uri = config['connection']['base_uri']
        
        login = orgcode + "\\" + username

        options = { :basic_auth => {:username => login, :password => submitted_password}, :base_uri => "http://" + tw_uri }
        # options = { :basic_auth => {:username => login, :password => submitted_password}, :base_uri => uri }
        begin
            response = get('/rest/v1/users/' + orgcode + '/' + username, options)
            response["user"]
        rescue Exception => e 
            puts "got exception!"
            puts e.message
        end
    end
end
