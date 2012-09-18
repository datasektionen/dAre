class StaffController < ApplicationController
	include ApplicationHelper

	def index
		current_project = get_project

		@staff_current = current_project.staff
		@staff_emeriti = Staff.where("id NOT IN (?)", @staff_current.select("id"))

	end

	def new

	end

	def edit

	end

	def create
		@staff = Staff.new(params[:staff])

		respond_to do |format|
			if @staff.save
	  			format.html {  }
	  			format.json { render json: @staff, status: :created, location: @staff }
	  			format.js { }
			else
				format.html { }
      			format.json { render json: @staff.errors, status: :unprocessable_entity }
	            format.js { }
			end
		end
	end

	def update
		@staff = Staff.find(params[:id])

		respond_to do |format|
	    	if @staff.update_attributes(params[:post])
	    		format.html { }
	    		format.json { render json: @staff, status: :created, location: @staff }
	    		format.js { }
	    	else
	    		format.html { }
      			format.json { render json: @staff.errors, status: :unprocessable_entity }
	            format.js { }
	    	end
    	end
	end

	def destroy
		Staff.find(params[:id]).destroy

    	respond_to do |format|
	    	format.html { redirect_to staff_index_path, success: "Staff member destroyed." }
	  		format.json { head :no_content }
	  		format.js { }
  		end
	end

end
