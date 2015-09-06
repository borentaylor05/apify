
require 'apify/core_ext'

module Apify
	BELONGSTO = "ActiveRecord::Reflection::BelongsToReflection"
	HASMANY = "ActiveRecord::Reflection::HasManyReflection"
  	@@except = []
  	def apify
      	hash = self.attributes
      	self.class.reflect_on_all_associations.each do |a|
      		unless @@except.include?(a.name)
	      		hash[a.name.to_s] = self.send(a.name) 
	      		if hash[a.name.to_s].is_a?(ActiveRecord::Base)
	      			hash[a.name.to_s] = apify_belongs_to(hash[a.name.to_s])
	      		end
	      	end
      	end
      	return hash
   	end

   	def apify_belongs_to(val)
   		newHash = self.attributes
   		val.class.reflect_on_all_associations.each do |a|
   			newHash[a.name.to_s] = val.send(a.name) if a.class.to_s == BELONGSTO
   		end
   		return newHash
   	end

  	def self.except(*e)
    	@@except = e
  	end
  
end