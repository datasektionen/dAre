# encoding: UTF-8
class AttendeeMailer < ActionMailer::Base
	include ApplicationHelper

	default :from => "dare@d.kth.se"
	default_url_options[:host] = ""

	def registration_mail(attendee)
		@attendee = attendee
		@project = get_project

		recipent = "#{@attendee.name} <#{@attendee.email}>"
		mail(:to => recipent, :subject => "Anmälan till dÅre")
	end

end
