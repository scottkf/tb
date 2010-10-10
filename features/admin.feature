@admin
Feature: Admin
  As an Admin
  In order to Administer the site
  I need to have access to all the articles


	Scenario: I can edit all the articles
		# Given the following articles exist:
		#   | Title     | Body 	| User | 
		#   | Article 1 | _hello_ | last_name: apple | 
		#   | Article 2 | _hello_ | last_name: mom | 
		Given I have an article 
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has an author "jim" "jones"
		And I am an authenticated user with name "steve" "brown"
		And I am an admin
		When I go to the homepage
  	Then I should see "Edit this article"
	
	
	

  
