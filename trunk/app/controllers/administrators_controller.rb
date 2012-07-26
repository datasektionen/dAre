class AdministratorsController < ApplicationController
  before_filter :is_administrator
  before_filter :correct_administrator,   only: [:edit, :update]

  def index
    @administrators = Administrator.paginate(page: params[:page])
  end

  def show
  	@administrator = Administrator.find(params[:id])
  end

  def new
  	@administrator = Administrator.new
  end

  def create
  	@administrator = Administrator.new(params[:administrator])
  	
    if @administrator.save
      flash[:success] = "The administrator has been created!"
  		redirect_to @administrator
  	else
  		render 'new'
  	end
  end

  def edit
    @administrator = Administrator.find(params[:id])
  end

  def update
    @administrator = Administrator.find(params[:id])
    
    if @administrator.update_attributes(params[:administrator])
      flash[:success] = "Administrator updated";
      sign_in @administrator
      redirect_to @administrator
    else
      render 'edit'      
    end
  end

  def destroy
    Administrator.find(params[:id]).destroy

    flash[:success] = "Administrator destroyed"
    redirect_to administrators_path
  end

  private

    def correct_administrator
      @administrator = Administrator.find(params[:id])
      redirect_to(root_path) unless current_administrator?(@administrator)      
    end

end
