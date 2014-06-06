class MainController < ApplicationController
	def index
		if(current_user.nil?)
			redirect_to "/signin"
		end

		@datasets = Dataset.all
	end

end
