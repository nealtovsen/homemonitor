class Tenant
    include HTTParty
    format :xml
    debug_output

    attr_accessor :orgcode, :name, :created

    def initialize
        config = YAML.load_file("config/telemetryweb.yml")
        self.class.base_uri config['connection']['base_uri']
    end

    def get_tenant(orgcode, current_user)

        if current_user.nil?
            Rails.logger.info("current_user is nil")
            raise TWSessionEnded
        end
        options = { :cookies => {:JSESSIONID => current_user.session_id} }
        response = self.class.get('/rest/v1/tenants/' + current_user.orgcode, options)
        # Rails.logger.debug("RESPONSE CODE: " + response.code.to_s)
        # Rails.logger.debug(response.to_s)
        if response.to_s.include? "Login Page"
            raise TWSessionEnded
        end
        tenant_resp = response["tenant"]

        tenant = Tenant.new()
        tenant.orgcode = tenant_resp["tenantCode"]
        tenant.name = tenant_resp["name"]
        tenant.created = tenant_resp["created"]

        return tenant
    end

end
