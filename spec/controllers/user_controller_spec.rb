require 'spec_helper'
describe UserController do
  

  describe "before authorization dialog" do
    context "when user is already authorized" do
      xit "should redirect to victorins index page" do
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