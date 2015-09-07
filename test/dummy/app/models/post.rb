class Post < ActiveRecord::Base
	include Apify
	belongs_to :user
end
