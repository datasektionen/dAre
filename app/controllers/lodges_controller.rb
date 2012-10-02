class LodgesController < ApplicationController
	before_filter :get_project

	def index
		@lodges = @project.lodges
		@lodgeless_registrations = @project.registrations.find(:all, :conditions => {:lodge_id => nil})
	end

	def show
		@lodge = Lodge.find(params[:id])
	end

	def new
		@lodge = Lodge.new
	end

	def create
		@lodge = @project.lodges.build(params[:lodge])
  	
	    if @lodge.save
	     	flash[:success] = "The lodge has been created!"
	  		redirect_to project_lodge_path(@project, @lodge)
	  	else
	  		render 'new'
	  	end
	end

	def edit
		@lodge = Lodge.find(params[:id])
	end

	def update
		@lodge = Lodge.find(params[:id])
    
	    if @lodge.update_attributes(params[:lodge])
	      flash[:success] = "Lodge updated.";
	      redirect_to project_lodge_path(@project)
	    else
	      render 'edit'      
	    end
	end

	def destroy
		Lodge.find(params[:id]).destroy

    	flash[:success] = "Lodge destroyed."
    	redirect_to project_lodges_path(@project)
	end

	def add_attendee
		@lodge = Lodge.find(params[:id])
		@attendee = Registration.find(params[:registration_id])

		@lodge.registrations << @attendee
		@lodge.save

		respond_to do |format|
	    	format.html { redirect_to root_path, success: "Attendee has been added to the lodge." }
	  		format.json { head :no_content }
	  		format.js { }
  		end
	end

	def remove_attendee
		@attendee = Registration.find(params[:registration_id])

		@attendee.lodge = nil
		@attendee.save

		respond_to do |format|
	    	format.html { redirect_to root_path, success: "Attendee has been removed from the lodge." }
	  		format.json { head :no_content }
	  		format.js { }
  		end
	end

	private

	def get_project
		@project = Project.find(params[:project_id])
	end

end
