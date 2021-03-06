@accounts
Feature: User Accounts
	As a user
	In order to post articles and maintain content
	I need to be able to create an account

	Scenario Outline: Creating a new account
		Given I am not authenticated
		When I go to register
		And I fill in "user_first_name" with "<first_name>"
		And I fill in "user_last_name" with "<last_name>"
		And I fill in "user_email" with "<email>"
		And I fill in "user_password" with "<password>"
		And I fill in "user_password_confirmation" with "<password>"
		And I press "Sign in"
		Then I should see "You have signed up successfully"
		Examples:
		  | first_name 			| last_name 			| email           | password   |
		  | bob							| carr						| testing@man.net | secretpass |
		  | foo							| bar							| foo@bar.com     | fr33z3     |

