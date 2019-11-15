#step_definitions/event_signup_company.rb

Given(/^I am on the company view page$/) do
	visit company_path
end

When /^I click the "([^\"]*)" link for "([^\"]*)"$/ do |link, cell_value|
  within "//*[.//td[contains(.,'#{cell_value}')] and .//a[text()='#{link}']]" do |scope|
    scope.click_link link
  end
end

Then(/^I should see "([^"]*)"$/) do |arg|
  expect(page).to have_content arg
end