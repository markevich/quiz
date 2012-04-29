require 'spec_helper'
describe UserController do
  

  describe "before authorization dialog" do
    before do
      mock_model(User)
    end
    context "when user is already authorized" do
      it "should redirect to index page" do
        User.stub!(:authorized).and_return(true)
      end
    end

    context "when user is not authorized" do
      it "should render login dialog" do
        User.stub!(:authorized).and_return(false)
      end
    end

  end
end