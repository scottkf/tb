Feature: Home Page
	As a user
	In order to view the most recent articles
	I need to see the latest articles
	
	Scenario: 1 article
		Given I have a article
		And my article has a title "Rant #1"
		And my article has body "..........L"
		And my article has an author named "Apple Man"
		When I go to the homepage
		Then I should see "Rant #1"
		And I should see "..........L"
		And I should see "Apple Man"
		