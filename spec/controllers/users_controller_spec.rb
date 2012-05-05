require 'spec_helper'
describe UsersController do
  let(:user_with_correct_password){mock('user', authenticate: true, id: 1)}
  let(:user_with_incorrect_password){mock('user', authenticate: false, id: 1)}
  describe '#login' do
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
  end

  describe '#authorize' do
    describe "when user try to authorize" do
      context "with correct data" do
        before do
          User.stub(:find).and_return user_with_correct_password
          post :authorize, user: {login: 'login', password: 'password'}
        end

        it "redirect to quiz index page" do
          response.should redirect_to(quizzes_path)
        end
        it "sets the current user" do
          controller.instance_eval{ current_user }.should == user_with_correct_password
        end
      end
      context "withoud data" do
        it "redirects back to login page" do
          post :authorize
          response.should redirect_to login_user_path
        end
      end
      context "with incorrect data" do
        it 'redirects back to login page if login not found' do
          User.stub(:find).and_return nil
          post :authorize, user: {login: 'login', password: 'password'}
          response.should redirect_to login_user_path
          controller.instance_eval{ current_user }.should be_nil
        end
        it 'redirects back to login page if password incorrect' do
          User.stub(:find).and_return user_with_incorrect_password
          post :authorize, user: {login: 'login', password: 'password'}
          response.should redirect_to login_user_path
          controller.instance_eval{ current_user }.should_not == user_with_incorrect_password
        end
      end
    end
  end

  describe '#logout' do
    context "when user logging out" do
      before do
        User.stub(:find).and_return user_with_correct_password
        post :authorize, user: {login: 'login', password: 'password'}
        get :logout
      end

      it "should redirect to login page" do
        response.should redirect_to login_user_path
      end

      it "should reset current_user" do
        controller.instance_eval{ current_user }.should be_nil
      end
    end
  end

end