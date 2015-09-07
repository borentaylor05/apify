class User < ActiveRecord::Base
	include Apify
	Apify.blacklist :created_at	
	belongs_to :company
	has_many :posts
end
