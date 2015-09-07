require 'test_helper'

# Company has_many users 
# User belongs_to a company
# User has_many posts
# Post belongs_to user


class ApifyTest < ActiveSupport::TestCase
	test "truth" do
		assert_kind_of Module, Apify
	end

	test "object responds to apify method" do 
		assert_equal true, User.first.respond_to?("apify") 
	end

	test "User instance hash contains name key (for self) when apify is called" do
		hash = User.first.apify
		assert_equal true, hash.has_key?("name")
	end

	test "User instance hash contains a company key" do 
		hash = User.first.apify
		assert_equal true, hash.has_key?("company")
	end

	test "User instance hash contains a Company with a name" do 
		hash = User.first.apify
		puts hash.to_json	
		assert_equal false, hash["company"]["name"].nil?
	end

	test "User instance has posts key" do 
		hash = User.first.apify
		assert_equal true, hash.has_key?("posts")
	end

	test "User instance hash has a array of posts" do 
		hash = User.first.apify
		assert_equal true, hash["posts"].is_a?(Array)
	end

	test "Post instance hash should return user key" do 
		hash = Post.first.apify		
		assert_equal true, hash.has_key?("user")
	end

	test "Post instance hash should return user hash with company key" do 
		hash = Post.first.apify		
		assert_equal true, hash["user"].has_key?("company")
	end

	test "Company should have users" do 
		hash = Company.first.apify
		assert_equal true, hash.has_key?("users")
	end

	test "Company should not have posts" do 
		hash = Company.first.apify
		assert_equal false, hash.has_key?("posts")
	end

	test "array responds to apify method" do 
		assert_equal true, User.all.respond_to?("apify") 
	end

end
