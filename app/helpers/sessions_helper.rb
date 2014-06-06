module SessionsHelper

	def sign_in(user)
		session[:current_user_id] = user.to_param

		self.current_user = user
	end


	def current_user=(user)
		@current_user = user
	end

	def current_user
		if(!session[:current_user_id])
			return nil
		end
		@current_user ||= User.find_by(id: session[:current_user_id])
	end
end
