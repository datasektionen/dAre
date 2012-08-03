module SessionsHelper

	def sign_in(kth_id)
		session[:remember_token] = kth_id

		administrator = Administrator.find_by_kth_id(kth_id)

		if administrator
    		self.current_administrator = administrator
    	end
    	
    	self.current_attendee = Registration.find_by_kth_id(kth_id)
	end

	def current_attendee=(attendee)
		@current_attendee = attendee
	end

	def current_attendee
		@current_attendee ||= Registration.find_by_kth_id(session[:remember_token])
	end

	def current_administrator=(administrator)
		@current_administrator = administrator
	end

	def current_administrator
		@current_administrator ||= Administrator.find_by_kth_id(session[:remember_token])
	end

	def current_user?(user)
		if user.instance_of? Administrator
			user == current_administrator
		elsif user.instance_of? Registration
			user == current_attendee
		end
	end

	def current_attendee?(attendee)
		attendee == current_attendee
	end

	def current_administrator?(administrator)
		administrator == current_administrator
	end
	
	def signed_in_attendee?
		!session[:remember_token].nil?
	end

	def signed_in_administrator?
		!current_administrator.nil?
    end
	
	def signed_in
	 	unless signed_in_attendee? || signed_in_administrator?
        	store_location
        	redirect_to signin_path, notice: "Please sign in to continue."
    	end
    end

	def is_administrator
	 	unless signed_in_administrator?
        	store_location
        	redirect_to signin_path, notice: "Please sign in to continue."
    	end
    end

	def sign_out
		self.current_administrator = nil
		self.current_attendee = nil
		session[:remember_token] = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
	end

	def store_location
		session[:return_to] = request.fullpath
	end

end
