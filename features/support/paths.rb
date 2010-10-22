module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/articles'
    
    when /the articles page/
      '/articles'
    
    when /the users page/
      '/users/'
      
    when /the category page/
      '/categories/'

    when /the (.*) category page/
      articles_category_url($1)
      
    when /the article page for "([^"]*)"/
      article_path(Article.find_by_title($1))

    when /the article page by permalink for "([^"]*)"/
      '/articles/' + Article.find_by_title($1).to_param

    when /register/
      '/users/sign_up'
    
    when /login/
      '/users/sign_in'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
