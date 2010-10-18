@management
Feature: User page
	As an admin
	In order to manage users and the website
	I need be able to access the users
	
	@index
	Scenario: A list of all users
		Given I am an authenticated user with name "steve" "brown"
		And I am an admin
		And there is a user with name "hello" "one"
		And there is a user with name "hello" "two"
		When I am on the users page
		Then I should see "hello one"
		And I should see "hello two"
		
	# @adding
	# Scenario: Adding a user
	# 	Given I am an authenticated user with name "steve" "brown"
	# 	And I am an admin
	# 	And I am on the home page
	# 	And I am on the users page
	# 	And I follow "Create User"
	# 	When I fill in "user[first_name]" with "hello"
	# 	And I fill in "user[last_name]" with "goodbye"
	# 	And I fill in "user[email]" with "hello@goodbye.com"
	# 	And I fill in "user[password]" with "123456"
	# 	And I fill in "user[password_confirmation]" with "hello!"
	# 	And I press "user_submit"
	# 	And I am on the users page
	# 	And show me the page
	# 	Then I should see "hello goodbye"
		
	@editing
	Scenario: Editing a user
		Given I am an authenticated user with name "steve" "brown"
		And I am an admin
		And I am on the users page
		And I follow "Edit"
		When I fill in "user[first_name]" with "hello"
		And I fill in "user[last_name]" with "goodbye"
		And I fill in "user[email]" with "hello@goodbye.com"
		And I press "user_submit"
		And I am on the users page
		Then I should see "hello goodbye"
