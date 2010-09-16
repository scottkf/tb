Given /^I am not authenticated$/ do
  visit('/authors/sign_out') # ensure that at least
end


Given /^I am an authenticated user with name "([^"]*)" "([^"]*)"$/ do |f, l|
  first = f
  last = l
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  Given %{I have one author "#{first}" "#{last}" with email "#{email}" and password "#{password}"}
  And %{I go to login}
  And %{I fill in "author_email" with "#{email}"}
  And %{I fill in "author_password" with "#{password}"}
  And %{I press "Sign in"}
end

Given /^I have one author "([^"]*)" "([^"]*)" with email "([^"]*)" and password "([^"]*)"$/ do |first, last, email, password|
  Author.new(:first_name => first,
           :last_name => last,
           :email => email,
           :password => password,
           :password_confirmation => password).save!
end