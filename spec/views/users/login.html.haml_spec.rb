require 'spec_helper'

describe "users/login" do
  it "renders a form for user login" do
    render
    rendered.should have_selector("form",
      :method => "post",
      :action => authorize_user_path
    ) do |form|
      form.should have_selector("input", :type => "submit")
    end
  end

  it "renders a text field for the user login" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
        :type => "text",
        :name => "user[login]",
      )
    end
  end

  it "renders a text field for the user password" do
    render
    rendered.should have_selector("form") do |form|
      form.should have_selector("input",
        :type => "text",
        :name => "user[password]",
      )
    end
  end

  it "renders link for user registration" do
    render
    rendered.should have_selector("a", :id => 'register', :href => new_user_path)
  end
end
