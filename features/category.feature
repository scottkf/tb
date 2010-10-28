@category
Feature: Category
  In order to view content in an organized way
  As a user
  I want to manage categories


	@index
	Scenario: A list of all categories
		Given I am an authenticated user with name "steve" "brown"
		And I am an admin
		And there is a category with name "hello" and url "hello23"
		When I am on the category page
		Then I should see "hello"
		And I should see "hello23"
		
	
		
	@adding
	Scenario: Adding a category
		Given I am an authenticated user with name "steve" "brown"
		And I am an admin
		And I am on the home page
		And I am on the category page
		And I follow "Create Category"
		When I fill in "category[name]" with "hello"
		And I fill in "category[description]" with "goodbye"
		And I fill in "category[url]" with "hello2"
		And I fill in "category[layout]" with "hello"
		And I press "submit"
		Then I should see "hello"
		And I should see "goodbye"
		And I should see "hello2"
		And I should see "hello"
		
	@editing
	Scenario: Editing a category
		Given I am an authenticated user with name "steve" "brown"
		And I am an admin
		And there is a category with name "hello" and url "hello23"
		And I am on the category page
		And I follow "Edit"
		When I fill in "category[name]" with "goodbye"
		And I fill in "category[url]" with "epic"
		And I fill in "category[description]" with "loooooong"
		And I press "submit"
		Then I should see "goodbye"
		And I should see "epic"
		And I should see "loooooong"
	
	@parents
	Scenario: I shouldn't see myself listed as a choice for my parent
		Given I am an authenticated user with name "steve" "brown"
		And I am an admin
		And there is a category with name "hello" and url "hello23"
		And I am on the category page
		When I follow "Edit"
		Then "hello" should not be seen within select "category[parent_id]"
	
	
	
	
	# fopen to add something unique to the layout to check for it
	@layout
	Scenario: Visiting a category's url should render a different layout
	 	Given I am not authenticated
 		# it shouldn't matter --^
		And there is a category with name "hello" and url "hello23"
		And I have an article in that category
		And the layout has "<html><body><h1>UNCOMMONSHIBBOLETH</h1><%= yield %></body></html>"
	 	When I am on the hello23 category page
		And show me the page
	 	Then I should see "UNCOMMONSHIBBOLETH" within "h1"
	
	
	@noarticles
	Scenario: Viewing a category with no articles
		Given I am not authenticated
		# it shouldn't matter --^
		And there is a category with name "hello" and url "hello23"
		When I am on the hello23 category page
		Then I should be on the articles page
		# because there are no articles
	
	@actualarticles
	Scenario: Viewing a category with at least one article
	 	Given I am not authenticated
		# it shouldn't matter --^
		And I have an article
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has a category with name "DancingBeetle" and url "beetle"
		And the article has an author "steve" "brown"
		And the layout has "<html><body><h1>UNCOMMONSHIBBOLETH</h1><%= yield %></body></html>"
	 	When I am on the beetle category page
	 	Then I should see "UNCOMMONSHIBBOLETH" within "h1"
		And I should see "hello"
		And I should see "....L"
		
		
	@subcatlist
	Scenario: I should be able to see all articles subcategorized
		Given there is a category with name "hello" and url "hello23"
		And I have an article in that category with title "bobby jones"
		And there is a category with name "absolute" and url "absolute"
		And that category has a parent with name "hello"
		And I have an article in that category with title "epic misery"
		When I am on the hello category page
		Then I should see "bobby jones"
		And I should see "epic misery"

	
	@individualarticle
	Scenario: Viewing an individual article should be shown with the layout
	 	Given I am not authenticated
		# it shouldn't matter --^
		And I have an article
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has a category with name "DancingBeetle" and url "beetle"
		And the article has an author "steve" "brown"
		And the layout has "<html><body><h1>UNCOMMONSHIBBOLETH</h1><%= yield %></body></html>"
	 	When I go to the article page for "hello" 
	 	Then I should see "UNCOMMONSHIBBOLETH" within "h1"
		And I should see "hello"
		And I should see "....L"
	
	
	@javascript
	@categoryadd
	Scenario: Adding a category from the category list within an article
		Given I am an authenticated user with name "lifetime" "sack"
		And I have a category with name "JoyridingMuffin"
		And I am an editor
		And I have an article
		And the article has a title "hello"
		And the article has a body "....L"
		And the article has a category with name "DancingBeetle"
		And I authored the article
		And I go to the homepage
	  	When I am on the homepage
		And I follow "Edit this article"
		And I follow "add a new category"
		And I wait until "new_category" is visible
		And I fill in "category[name]" with "hello"
		And I fill in "category[description]" with "goodbye"
		And I fill in "category[url]" with "hello2"
		And I fill in "category[layout]" with "hello"
		And I press "submit"
	  	Then "hello" should be selected for "article_category_id"
	
	
	
	
	
	
