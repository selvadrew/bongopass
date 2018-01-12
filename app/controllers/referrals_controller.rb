class ReferralsController < ApplicationController
	include CurrentReferral
	before_action :set_referral, only: [:show, :mypass]
	before_action :invite_referral, only: [:show, :mypass]
 	before_action :is_authorized, only: [:mypass]

	def show
		@event = @referral.order.ticket.event 
		@photos = @event.photos
    	@tickets = @event.tickets 
    	@user = User.where(id: @referral.order.buyer_id).first
    	@current_purchases = Order.where(referral_id: @referral.id).count
    	@friends_joined = Order.where(referral_id: @referral.id)
    	@bongopass_fee = 3.50
	end

	def mypass 
		@event = @referral.order.ticket.event 
		@photos = @event.photos
    	@tickets = @event.tickets 
    	@user = User.where(id: @referral.order.buyer_id).first
    	@current_purchases = Order.where(referral_id: @referral.id).count
    	@friends_joined = Order.where(referral_id: @referral.id)
    	@bongopass_fee = 3.50 

    		set_meta_tags
              title: "hey",
              description: @event.organizer_name,
              type:     'article'
          	


	end



	private
	    def set_referral
	      @referral = Referral.find(params[:id])
	    end


	    def is_authorized
      		redirect_to referral_path, alert: "You don't have permission" unless current_user.present? && current_user.id == @referral.order.buyer_id
   		end
	


end

