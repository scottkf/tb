Given /^I am not authenticated$/ do
  visit('/authors/sign_out') # ensure that at least
end

Given /^I am an authenticated user with name "([^"]*)" "([^"]*)"$/ do |f, l|
  
  @author = Author.make!(:first_name => f, :last_name => l)
  And %{I go to login}
  And %{I fill in "author_email" with "#{@author.email}"}
  And %{I fill in "author_password" with "#{@author.password}"}
  And %{I press "Sign in"}
end