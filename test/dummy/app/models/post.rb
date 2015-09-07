class Post < ActiveRecord::Base
	include Apify
	Apify.blacklist :created_at
	belongs_to :user
end
