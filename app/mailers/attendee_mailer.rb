# encoding: UTF-8
class AttendeeMailer < ActionMailer::Base
	include ApplicationHelper

	default :from => "dare@d.kth.se"
	default_url_options[:host] = "dare.datasektionen.se"

	def registration_email(attendee)
		@attendee = attendee
		@project = get_project

		recipent = "#{@attendee.firstname + " " + @attendee.surname} <#{@attendee.email}>"
		mail(:to => recipent, :subject => "Anmälan till dÅre " + @project.year.to_s)
	end

	def reserve_email(attendee)
		@attendee = attendee
		@project = get_project

		recipent = "#{@attendee.firstname + " " + @attendee.surname} <#{@attendee.email}>"
		mail(:to => recipent, :subject => "Anmälan till dÅre " + @project.year.to_s)
	end

	def mail_all(message)
		@project = get_project
		@message = message
		bcc = @project.registrations.where(:reserve => false).map(&:email)
		mail(:to => 'dare@d.kth.se', :bcc => bcc, :subject => "dÅre " + @project.year.to_s)
	end

end
