class Array 
	def apify
		self.map(&:apify)
	end
end
