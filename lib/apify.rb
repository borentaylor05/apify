
require 'apify/core_ext'
require 'apify/apify_respond'

module Apify
	BELONGSTO = "ActiveRecord::Reflection::BelongsToReflection"
	HASMANY = "ActiveRecord::Reflection::HasManyReflection"
    HASMANYTHROUGH = "ActiveRecord::Reflection::ThroughReflection"
    @@except = []
    @@blacklist = []

  	def apify(belongs_to_only = false)
      	hash = self.attributes.except(*@@blacklist.map { |b| b.to_s })
      	self.class.reflect_on_all_associations.each do |a|
      		unless @@except.include?(a.name)
                if self.send(a.name)
                    if a.class.to_s ==  BELONGSTO  
                        begin              
                            hash[a.name.to_s] = self.send(a.name).attributes.except(*@@blacklist.map { |b| b.to_s })  
                            # objectify takes a string parameter that must be equal to the class name you are trying to convert to
                            hash[a.name.to_s] = hash[a.name.to_s].objectify(a.name).apify(true)
                        rescue NoMethodError
                            puts a.class
                            puts "Be sure to add `include Apify` to all models"
                        end
                    elsif !belongs_to_only and (a.class.to_s == HASMANY or a.class.to_s == HASMANYTHROUGH)
                        hash[a.name.to_s] = self.send(a.name).map{ |at| at.attributes.except(*@@blacklist.map { |b| b.to_s })  }
                    end
                else   
                    hash[a.name.to_s] = self.send(a.name)               
                end	   
	      	end
      	end
      	return hash
   	end

  	def self.except(*e)
        e.each { |exc| @@except.push exc }
  	end

    def self.blacklist(*b)
        b.each { |bl| @@blacklist.push bl }
    end
  
end