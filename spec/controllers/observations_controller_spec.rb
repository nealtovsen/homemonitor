require 'spec_helper'

describe ObservationsController do
  render_views
   
  describe "GET 'show'" do

    it "should be successful" do
      get :show
      response.should be_success
    end

  end

end
