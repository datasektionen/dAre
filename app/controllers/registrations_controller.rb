class RegistrationsController < ApplicationController
    before_filter :get_project
    before_filter :signed_in, except: :index

    # GET /registrations
    # GET /registrations.json
    def index
        @registrations = @project.registrations.paginate(page: params[:page], :conditions => { :reserve => false }, :order => :firstname, :per_page => 20)
        
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @registrations }
        end
    end

    def reserves
        @reserves = @project.registrations.paginate(page: params[:page], :conditions => { :reserve => true }, :order => :firstname, :per_page => 20)

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
        if current_attendee != nil && current_administrator == nil
            flash[:error] = 'Du ar redan registrerad.'
            redirect_to project_registration_path(@project, current_attendee) and return
        end

        if !@project.openRegistration
            redirect_to root_path, :flash => { :error => 'Anmalan ar inte oppen.' } and return
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

        if !signed_in_administrator?
            if current_attendee.kth_id != @registration.kth_id
                redirect_to root_path, :flash => { :error => 'Sa dar far man icke gora!.' } and return
            end
        end
    end

    # POST /registrations
    # POST /registrations.json
    def create
        @registration = @project.registrations.build(params[:registration])
        @registration.kth_id = session[:remember_token]

        if @project.registrations.count >= @project.spots
            @registration.reserve = true
        end

        if current_attendee != nil && current_administrator != nil
            @registration.kth_id = 'outsider'
        end

        respond_to do |format|
            if @registration.save
                current_attendee = @registration

                #AttendeeMailer.registration_mail(@registration).deliver

                format.html { redirect_to project_registration_path(@project, @registration), notice: 'Din anmalan har sparats.' }
                format.json { render json: @registration, status: :created, location: @registration }
            else
                format.html { render action: 'new' }
                format.json { render json: @registration.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /registrations/1
    # PUT /registrations/1.json
    def update
        @registration = Registration.find(params[:id])

        if !signed_in_administrator?
            if current_attendee.kth_id != @registration.kth_id
                redirect_to root_path, :flash => { :error => 'Sa dar far man icke gora!.' } and return
            end
        end

        respond_to do |format|
            if @registration.update_attributes(params[:registration])
                format.html { redirect_to project_registration_path(@project, @registration), notice: 'Din anmalan har sparats.' }
                format.json { head :ok }
            else
                format.html { render action: 'edit' }
                format.json { render json: @registration.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /registrations/1
    # DELETE /registrations/1.json
    def destroy
        if !signed_in_administrator?
            redirect_to root_path, :flash => { :error => 'Sa dar far man icke gora!.' } and return
        end

        @registration = Registration.find(params[:id])
        @registration.destroy

        respond_to do |format|
            format.html { redirect_to project_registrations_path(@project), notice: 'Anmalan har tagits bort.' }
            format.json { head :ok }
        end
    end

    private

    def get_project
        @project = Project.find(params[:project_id])
    end

end 