@home
Feature: Home Page
	As a user
	In order to view the most recent articles
	I need to see the latest articles
	
	@index
	Scenario: 1 article
		Given I have an article 
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has an author "steve" "brown"
		And I am not authenticated
		When I go to the homepage
		Then I should see "hello"
		And I should see "....L"
		And I should see "steve brown"
		
	@javascript	@adding
	Scenario: Adding an article
		Given I am an authenticated user with name "jim" "johnson"
		And I am on the home page
		When I fill in "article[title]" with "hello"
		And I fill in "article[body]" with "_this is the body_"
		And I press "submit"
		Then I should see "hello"
		And I should see "this is the body"
		And I should see "jim johnson"
		
	@javascript @editing
	Scenario: Editing an article
		Given I am an authenticated user with name "lifetime" "sack"
		And I have an article
		And the article has a title "hello"
		And the article has a body "....L"
		And I authored the article
		And I go to the homepage
		And I follow "Edit this article"
		When I fill in "article[title]" with "hello"
		And I fill in "article[body]" with "_this is the body_"
		And I press "submit"
		Then I should see "hello"
		And I should see "this is the body"
		And I should see "lifetime sack"
		
		

	
	
	
	