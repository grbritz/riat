class ApplicationController < ActionController::Base
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def initialize
  	super
  	@nav_datasets = Dataset.all
  end
  
  
  
 protected 
 	def require_logged_in
 		if(current_user.nil?)
 			flash[:message] = {message: "You must be logged in to visit that page", display_type: "danger" }
			redirect_to "/signin"
		end
 	end

end
