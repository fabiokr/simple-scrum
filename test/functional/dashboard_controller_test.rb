require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

    context "on GET to :show" do
      setup do
        get :show
      end

      should_respond_with :success
    end

end

