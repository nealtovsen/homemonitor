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
        # Sign the user in and redirect to the user's show page.

        # TODO: Need to get orgcode from the webservice, instead of from the user.
            user["orgcode"] = params[:session][:organization_code]
        # TODO: Need to get rid of password in session. Use TW sessions instead.
            user["password"] = params[:session][:password]
            puts "NEW SIGNIN USER: " + user.to_s
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
