When(/open page "([^"]*)"$/) do |path|
  visit path
end

And(/^path should be "([^"]*)"$/) do |path|
  current_path.should == path
end

And(/click button "([^"]*)"$/) do |button_id|
  find(button_id).click
end

And(/^choose "([^"]*)"/) do |radio_id|
  choose(radio_id)
end

And(/click tab "([^"]*)"$/) do |tab_id|
  find(tab_id).click
end

And(/check checkbox "([^"]*)"$/) do |checkbox_id|
  check(checkbox_id) 
end

When (/fill "([^"]*)" in field "([^"]*)"$/) do |value, field|
  fill_in field, with: value
end

When (/fill following data in inputs$/) do |table|
  table.rows_hash.each do |key, value|
    fill_in key, with: value
  end
end

When (/click link "([^"]*)"$/) do |link|
  click_link(link)
end

Then (/^page should have content "([^"]*)"$/) do |content|
  page.should have_content content
end

Then (/select "([^"]*)" in dropdown "([^"]*)"$/) do |value, dropdown|
  select(value, :from => dropdown)
end


When (/^use driver "([^"]*)"$/) do |driver|
  if driver == 'default'
    Capybara.use_default_driver
  else
    Capybara.current_driver = driver
  end
end