class OrderMailer < ApplicationMailer
	def send_email_to_buyer(buyer, event)
	    @buyer = buyer
	    @event = event
	    mail(to: @buyer.email, subject: "Order Confirmed - Now share your link and receieve up to $100")
  	end
end 