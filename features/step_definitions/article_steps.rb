Given /^I have an article$/ do
  @article = Article.make
end

Given /^I have a category with name "([^"]*)"$/ do |name|
  @category = Category.make!(:name => name)
end

Given /^the article has a category with name "([^"]*)"$/ do |name|
  @category = Category.make!(:name => name)
  @article.category = @category
end

Given /^the article has a category with name "([^"]*)" and url "([^"]*)"$/ do |name, url|
  @category = Category.make!(:name => name, :url => url)
  @article.category = @category
end

Given /^the article has a title "([^"]*)"$/ do |title|
  @article.title = title
end

Given /^the article has a body "([^"]*)"$/ do |body|
  @article.body = body
end

Given /^the article has an author "([^"]*)" "([^"]*)"$/ do |f, l|
  @article.user = User.make!(:first_name => f, :last_name => l)
  @article.save
end

Given /^I authored the article$/ do
  @article.user = @user
  @article.save
end

Given /^the article has comments disabled$/ do
  @article.comments_disabled = true
end


