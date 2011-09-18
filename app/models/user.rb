class User
    include HTTParty
    format :xml
    debug_output
    
    attr_accessor :session_id, :username, :orgcode, :firstname, :lastname, :timezone

    def initialize
    end

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    def self.authenticate(orgcode, username, submitted_password)

        config = YAML.load_file("config/telemetryweb.yml")
        # self.class.base_uri config['connection']['base_uri']
        tw_uri = config['connection']['base_uri']
        tw_scheme = config['connection']['scheme']

        login = orgcode + "\\" + username

        options = { :basic_auth => {:username => login, :password => submitted_password}, :base_uri => tw_scheme + "://" + tw_uri }
        begin
            response = get('/rest/v1/users/' + orgcode + '/' + username, options)
            resp_user = response["user"]
            user = User.new()
            user.session_id = self.parse_jsessionid(response.headers["set-cookie"])
            user.orgcode = orgcode
            user.username = resp_user["username"]
            user.firstname = resp_user["firstName"]
            user.lastname = resp_user["lastName"]
            user.timezone = 'Central Time (US & Canada)'
            return user
        rescue Exception => e
            puts "got exception!"
            puts e.message
        end
    end


    def self.parse_jsessionid(setCookieHeader)
        cookies = setCookieHeader.split(' ')
        cookies.each do |cookie|
        	if (cookie.split("=")[0] == "JSESSIONID")
        		return jsessionid = cookie.split("=")[1].split(";")[0]
        	end
        end
    end
end
