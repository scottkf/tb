require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do 
  first_name { "alf" }
  last_name { "jones" }
  email { "#{object.first_name}.#{object.last_name}.#{sn}@example.com".downcase }
  password { "123456" }
  password_confirmation { "#{object.password}" }
end

Article.blueprint do
  title {"some title"}
  body {"_here is some content_"}
  permalink {"#{object.title}"}
  user
  category
end

Category.blueprint do
  name {"hello"}
  layout {"crazylongfilenamenoonewilluse"}
  description {"this is a description"}
  url {"hello#{sn}"}
end