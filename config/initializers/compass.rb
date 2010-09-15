require 'compass'
require 'compass/app_integration/rails'
#require "fileutils"

Compass::AppIntegration::Rails.initialize!
#FileUtils.mkdir_p(Rails.root.join("tmp", "stylesheets", "compiled"))
#ActionController::Middleware.use(Rack::Static, :root => "tmp/", :urls => ["/stylesheets"])