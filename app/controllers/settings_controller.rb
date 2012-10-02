class SettingsController < ApplicationController

	def index
		@settings = Setting.paginate(page: params[:page])
	end

	def show
		@setting = Setting.find(params[:id])
	end

	def new
		@setting = Setting.new
	end

	def create
		@setting = Setting.new(params[:setting])
  		
  		if @setting.save
      		flash[:success] = "The setting has been created!"
  			redirect_to @setting
  		else
  			render 'new'
  		end
	end

	def edit
		@setting = Setting.find(params[:id])
	end

	def update
		@setting = Setting.find(params[:id])
    	
    	if @setting.update_attributes(params[:setting])
      		flash[:success] = "Setting updated";
      		redirect_to @setting
    	else
      		render 'edit'      
    	end
	end

	def destroy
		Setting.find(params[:id]).destroy

    	flash[:success] = "Setting destroyed"
    	redirect_to settings_path
	end

end
