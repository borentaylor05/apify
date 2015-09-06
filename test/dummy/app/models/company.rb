class Company < ActiveRecord::Base
	include Apify
	has_many :users

end
