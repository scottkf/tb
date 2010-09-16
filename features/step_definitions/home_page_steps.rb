Given /^I have a article$/ do
  @article = Article.new
end



Given /^my article has a title "([^"]*)"$/ do |title|
  @article.title = title
end

Given /^my article has body "([^"]*)"$/ do |body|
  @article.body = body
end

Given /^my article has an author named "([^"]*)" "([^"]*)" "([^"]*)"$/ do |first, last, email|
  @article.author = Author.new(:first_name => first, :last_name => last, :email => email, :password => 'bob123123123', :password_confirmation => 'bob123123123')
  @article.save
end
