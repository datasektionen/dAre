class RegistrationsController < ApplicationController
  before_filter :get_project

  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = @project.registrations

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = @project.registrations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    if current_attendee != nil
      flash[:error] = "You are already registered."
      redirect_to current_attendee
    end

    @registration = Registration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = @project.registrations.build(params[:registration])

    respond_to do |format|
      if @registration.save
        format.html { redirect_to [@project, @registration], notice: 'Registration was successfully created.' }
        format.json { render json: @registration, status: :created, location: @registration }
      else
        format.html { render action: new_project_registration_path(@project) }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to [@project, @registration], notice: 'Registration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: edit_project_registration_path(@project) }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to project_registrations_path(@project), notice: 'Registration destroyed.' }
      format.json { head :ok }
    end
  end

  private

  def get_project
    @project = Project.find(params[:project_id])
  end

end
