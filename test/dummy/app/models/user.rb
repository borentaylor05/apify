class User < ActiveRecord::Base
	include Apify
	belongs_to :company
	has_many :posts
end
