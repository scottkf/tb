Given /^I have a article$/ do
  @article = Article.new
end

Given /^my article has a title "([^"]*)"$/ do |title|
  @article.title = title
end

Given /^my article has body "([^"]*)"$/ do |body|
  @article.body = body
end

Given /^my article has an author named "([^"]*)"$/ do |author|
  @article.author = Author.new(:name => author)
  @article.save
end
