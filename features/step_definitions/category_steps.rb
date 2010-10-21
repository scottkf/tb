Given /^there is a category with name "([^"]*)" and url "([^"]*)"$/ do |name, url|
  @category = Category.make!(:name => name, :url => url)
end

Given /^I have an article in that category$/ do
  @article = Article.make
  @article.category = @category
  @article.save
end

Given /^the layout has "([^"]*)"$/ do |content|
  File.open(Rails.root.join("app", "views", "layouts","#{@category.layout}.html.erb"), 'w') {|f| f.write(content) }
end


When /^I wait until "([^"]*)" is visible$/ do |selector|
  page.has_css?("#{selector}", :visible => true)
end

