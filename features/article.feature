@home
Feature: Articles
	As a user
	In order to view the most recent articles
	I need to see the latest articles
	
	
	@published
	Scenario: A published article shouldn't be seen
	  Given I have an unpublished article with title "awesomely epic title is here"
	  When I go to the homepage
	  Then should not see "awesomely epic title is here"
	
	
	
	
	@index
	Scenario: Home page
		Given I have an article 
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has an author "steve" "brown"
		And I am not authenticated
		When I go to the homepage
		Then I should see "hello"
		And I should see "....L"
		And I should see "steve brown"
		
	@permalink
	Scenario: Show an article by permalink
		Given I have an article 
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has an author "steve" "brown"
		And I am not authenticated
	 	When I go to the article page by permalink for "hello"
		Then I should see "hello"
		And I should see "....L"
		And I should see "steve brown"
	
	
	
	# 	
	# @show
	# Scenario: Showing an individual article with comments
	# 	Given I have an article 
	# 	And the article has a title "hello"
	# 	And the article has a body "....L"
	# 	And the article has an author "steve" "brown"
	# 	And I am not authenticated
	# 	And I go to the homepage
	# 	When I follow "hello"
	# 	Then I should see "hello"
	# 	And I should see "....L"
	# 	And I should see "steve brown"
	# 	And show me the page
	# 	And I should see "View the discussion thread"

	@show
	Scenario: Showing an individual article with comments disabled
		Given I have an article 
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has an author "steve" "brown"
		And the article has comments disabled
		And I am not authenticated
		And I go to the homepage
		When I follow "hello"
		Then I should see "hello"
		And I should see "....L"
		And I should see "steve brown"
		And I should not see "View the discussion thread"

		
	@javascript	@adding
	Scenario: Adding an article
		Given I am an authenticated user with name "jim" "johnson"
		And I have a category with name "JoyridingMuffin"
		And I am an editor
		And I am on the home page
		When I fill in "article[title]" with "hello"
		And I fill in "article[body]" with "_this is the body_"
		And I select "JoyridingMuffin" from "article[category_id]"
		And I press "submit"
		Then I should see "hello"
		And I should see "this is the body"
		And I should see "jim johnson"
		
	@editing
	Scenario: Editing an article
		Given I am an authenticated user with name "lifetime" "sack"
		And I have a category with name "JoyridingMuffin"
		And I am an editor
		And I have an article
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has a category with name "DancingBeetle"
		And I authored the article
		And I go to the homepage
		And I follow "Edit this article"
		When I fill in "article[title]" with "hello"
		And I fill in "article[body]" with "_this is the body_"
		And I press "submit"
		Then I should see "hello"
		And I should see "this is the body"
		And I should see "lifetime sack"
		
		

	
	
	
	