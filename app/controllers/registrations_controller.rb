class RegistrationsController < ApplicationController
    include ApplicationHelper

    before_filter :fetch_project
    before_filter :signed_in, :except => [:index, :reserves]
    before_filter :is_administrator, :only => [:destroy, :payment_mail]

    # GET /registrations
    # GET /registrations.json
    def index
        @registrations = @project.registrations.by_registrations
        
        if !params[:filter_not_payed].nil? && params[:filter_not_payed] == 'registration'
            @registrations = @registrations.by_not_payed_registration
        elsif !params[:filter_not_payed].nil? && params[:filter_not_payed] == 'total'
            @registrations = @registrations.by_not_payed_total
        end

        @registrations = @registrations.paginate(page: params[:page], :order => :firstname, :per_page => 20)

        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @registrations }
        end
    end

    def reserves
        @reserves = @project.registrations.by_reserve.paginate(page: params[:page], :order => :created_at, :per_page => 20)

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
            flash[:error] = 'Du ar redan registrerad / You are already registered.'
            redirect_to project_registration_path(@project, current_attendee) and return
        end

        if !@project.openRegistration && !signed_in_administrator?
            redirect_to root_path, :flash => { :error => 'Anmalan ar inte oppen / Registration is not open.' } and return
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
                redirect_to root_path, :flash => { :error => 'Sa dar for man inte gora! No access!' } and return
            end
        end
    end

    # POST /registrations
    # POST /registrations.json
    def create
        @registration = @project.registrations.build(params[:registration])
        @registration.kth_id = session[:remember_token]

        if !@project.openRegistration && !signed_in_administrator?
            redirect_to root_path, :flash => { :error => 'Anmalan ar inte oppen / Registration is not open' } and return
        end

        if @project.registrations.count >= @project.spots
            @registration.reserve = true
        end

        if current_attendee != nil && current_administrator != nil
            @registration.kth_id = rand(36**8).to_s(36)
        end

        if current_administrator.nil?
            @registration.hasPayedRegistration = false
            @registration.hasPayedTotal = false
        end

        respond_to do |format|
            if @registration.save
                current_attendee = @registration

                #if !@registration.reserve
                #    AttendeeMailer.registration_email(@registration).deliver
                #else
                #    AttendeeMailer.reserve_email(@registration).deliver
                #end

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
        registration = Registration.find(params[:id])

        if !signed_in_administrator?
            if current_attendee.kth_id != registration.kth_id
                redirect_to root_path, :flash => { :error => 'Sa dar far man icke gora! No access!' } and return
            end
        else
            #fix for reserve and payment fields
            registration.reserve = params[:registration][:reserve]
            registration.hasPayedRegistration = params[:registration][:hasPayedRegistration]
            registration.hasPayedTotal = params[:registration][:hasPayedTotal]
        end
        
        puts params[:registration]
        respond_to do |format|
            if registration.update_attributes(params[:registration])
                format.html { redirect_to project_registration_path(@project, registration), notice: 'Din anmalan har sparats. / Your registration has been saved.' }
                format.json { head :ok }
            else
                format.html { render action: 'edit' }
                format.json { render json: registration.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /registrations/1
    # DELETE /registrations/1.json
    def destroy
        if !signed_in_administrator?
            redirect_to root_path, :flash => { :error => 'Sa dar far man icke gora! / No access!' } and return
        end

        @registration = Registration.find(params[:registration_id])
        @registration.destroy

        respond_to do |format|
            format.html { redirect_to project_registrations_path(@project), notice: 'Anmalan har tagits bort / Registration removed' }
            format.json { head :ok }
        end
    end

    def payment_mail
        registration = Registration.find(params[:registration_id])
        if !registration.reserve
            #AttendeeMailer.registration_email(registration).deliver
        end

        redirect_to project_registration_path(@project, registration), notice: 'Betalningsmail skickat / Payment mail sent'  
    end

    private

    def fetch_project
        @project = get_project
    end

end 
