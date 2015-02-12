module UsersHelper
	def sign_in(user)
		session[:session_token] = user.session_token
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user
		@current_user ||= User.find_by_session_token(session[:session_token])
	end

	def current_user?(user)
		current_user == user
	end
end
