class SessionsController < ApplicationController

	def new
		
	end

	def create
		auth_hash = request.env['omniauth.auth']
		kth_id = auth_hash['uid']
		
		if kth_id
			sign_in kth_id
			
			if current_administrator
				redirect_back_or current_administrator
			elsif current_attendee
				redirect_back_or current_attendee
			else
				redirect_to registrations_new_path
			end
		else
			flash.now[:error] = "You do not have permission to proceed."
			render 'new'
		end	
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
