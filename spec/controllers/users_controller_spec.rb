require 'spec_helper'
describe UsersController do

  describe "before authorization dialog" do
    it "checks for current user authorization" do
      controller.should_receive('user_authorized?')
      get :login
    end
    context "when user is already authorized" do
      it "redirect to quiz index page" do
        controller.stub!('user_authorized?').and_return true
        get :login
        response.should redirect_to quizzes_path
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

  describe "when user try to authorize" do
    context "withoud data" do
      it "redirects back to login page" do
        post :authorize
        response.should redirect_to login_user_path
      end
    end
    context "with correct data" do
      let(:user){mock('user', authenticate: true, id: 1)}
      before do
        User.stub(:find_by_login).and_return user
        post :authorize, user: {login: 'login', password: 'password'}
      end

      it "redirect to quiz index page" do
        response.should redirect_to(quizzes_path)
      end
      it "sets the current user" do
        User.stub(:find).and_return user
        controller.instance_eval{ current_user }.should_not be_nil
      end

    end
  end

  
end