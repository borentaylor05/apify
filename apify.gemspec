$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "apify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "apify"
  s.version     = Apify::VERSION
  s.authors     = ["Taylor Boren"]
  s.email       = ["taylorboren86@gmail.com"]
  s.summary     = "Resolve Rails associations to return JSON objects more suitable for API consumption"
  s.description = "Looks at all associations of an ActiveRecord::Base object and returns a hash containing all associatied objects.  The key name is the association name."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "pg"
end
