class SessionsController < ApplicationController

	def new
		
	end

	def create
		auth_hash = request.env['omniauth.auth']

		administrator = Administrator.find_by_kth_id(auth_hash['uid'])
		if administrator
			sign_in administrator
			redirect_back_or administrator
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
