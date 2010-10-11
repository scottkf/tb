Given /^there is a user with name "([^"]*)" "([^"]*)"$/ do |f, l|
  @user = User.make!(:first_name => f, :last_name => l)
end
