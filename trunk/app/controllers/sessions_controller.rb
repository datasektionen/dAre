class SessionsController < ApplicationController
	before_filter CASClient::Frameworks::Rails::Filter, :only => :create

	def new
		administrator = Administrator.find_by_kth_id(session[:cas_user])
		if administrator
			sign_in administrator
			redirect_back_or administrator
		else
			flash.now[:error] = 'You must be logged in to proceed.'
			render 'new'
		end	
	end

	def create
					
	end

	def destroy
		CASClient::Frameworks::Rails::Filter.logout(self)
		sign_out
		redirect_to root_path
	end

end
