module Apify
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "APIfies your application models"

      def copy_initializer
        template "apify_initializer.rb", "config/initializers/apify.rb"

        puts "You have been APIfied!"
      end
    end
  end
end