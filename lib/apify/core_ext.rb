class Array 
	def apify
		self.map(&:apify)
	end
end

class Hash 
	# objectify takes a string parameter that must be equal to the class name you are trying to convert to
	def objectify(class_name)
		class_name.to_s.classify.constantize.new(self)
	end
end