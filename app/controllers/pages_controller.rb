class PagesController < ApplicationController

    def contact
        @title = "Contact"
    end

    def about
        @title = "About"
    end

    def help
        @title = "Help"
    end

    def home
        @title = "Home"
        if signed_in?
           redirect_to "/recent"
        end
    end
end
