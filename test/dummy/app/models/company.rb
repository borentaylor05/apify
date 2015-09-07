class Company < ActiveRecord::Base
	include Apify
	Apify.blacklist :updated_at
	has_many :users

end
