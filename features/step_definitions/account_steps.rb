Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I am an authenticated user with name "([^"]*)" "([^"]*)"$/ do |f, l|
  
  @user = User.make!(:first_name => f, :last_name => l)
  And %{I go to login}
  And %{I fill in "user_email" with "#{@user.email}"}
  And %{I fill in "user_password" with "#{@user.password}"}
  And %{I press "Sign in"}
end


Given /^I am an admin$/ do
  @user.admin = true
end

