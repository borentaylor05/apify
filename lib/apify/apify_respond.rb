module ApifyRespond
	def respond(response)
  		respond_to do |format|
  			format.any(:json, :html) { render json: response }
  		end
  	end
end