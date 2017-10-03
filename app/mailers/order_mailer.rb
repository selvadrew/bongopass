class OrderMailer < ApplicationMailer
	def send_email_to_buyer(buyer, event)
	    @buyer = buyer
	    @event = event
	    mail(to: @buyer.email, subject: "Enjoy You Event! 😘 💋")
  	end
end 