class SessionsController < ApplicationController

    def new
        @title = "Sign in"
    end

    def create
        user = User.authenticate(params[:session][:organization_code],
        params[:session][:username],
        params[:session][:password])

        if user.nil?
            # Create an error message and re-render the signin form.
            flash.now[:error] = "Invalid credentials."
            @title = "Sign in"
            render 'new'
        else
        	
        	session[:tenant] = Tenant.new.get_tenant(user.orgcode, user)
        # Sign the user in and redirect to root, or wherever they were headed.

        # TODO: Need to get orgcode from the webservice, instead of from the user.
        #user["orgcode"] = params[:session][:organization_code]
            puts "NEW SIGNIN USER: " + user.to_yaml
            sign_in user
            redirect_back_or root_path
        end
    end

    def destroy
        sign_out
        flash[:success] = "Your session has ended."
        redirect_to root_path
    end

end
