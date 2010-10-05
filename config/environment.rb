# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
A487teabagsCom::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address  => "mail.478teabags.com",
  :port  => 26,
  :user_name  => "web@478teabags.com",
  :password  => "ballss",
  :authentication  => :login,
  :enable_starttls_auto => false
}