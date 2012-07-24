module SessionsHelper

	def sign_in(administrator)
		session[:remember_token] = administrator.id
    	self.current_administrator = administrator
	end

	def signed_in?
		!current_administrator.nil?
	end

	def current_administrator=(administrator)
		@current_administrator = administrator
	end

	def current_administrator
		@current_administrator ||= Administrator.find_by_id(session[:remember_token])
	end

	def current_administrator?(administrator)
		administrator == current_administrator
	end
	
	def signed_in_administrator?
	  !current_administrator.nil?
    end
	
	def signed_in_administrator
	  unless signed_in_administrator?
        store_location
        redirect_to signin_path, notice: "Please sign in as administrator."
      end
    end

	def sign_out
		self.current_administrator = nil
		session[:remember_token] = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
	end

	def store_location
		session[:return_to] = request.fullpath
	end

end
