require 'spec_helper'
describe UsersController do

  describe "before authorization dialog" do
    it "check for current user authorization" do
      controller.should_receive('user_authorized?')
      get :login
    end
    context "when user is already authorized" do
      it "redirect to quiz index page" do
        controller.stub!('user_authorized?').and_return true
        get :login
        response.should redirect_to(quiz_path)
      end
    end

    context "when user is not authorized" do
      it "render login form" do
        controller.stub!('user_authorized?').and_return false
        get :login
        response.should render_template("login")
      end
    end
  end

  
end