class ReferralsController < ApplicationController
	include CurrentReferral
	before_action :set_referral, only: [:show]
	before_action :invite_referral, only: [:show]

	def show
		@event = @referral.order.ticket.event 
		@photos = @event.photos
    	@tickets = @event.tickets 
	end



	private
	    def set_referral
	      @referral = Referral.find(params[:id])
	    end
	


end

