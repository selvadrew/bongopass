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
    	@going = ' is going to '

    	set_meta_tags og: {	  
			title:       @referral.order.first_name + @going + @event.event_title,
			description: @event.event_description.html_safe,
			type:        'article',
			url:         referral_url(@referral),
			image:       @photos[0].image.url(:original),
			app_id:   1870680056482347
        }
	end

	def mypass 
		@event = @referral.order.ticket.event 
		@photos = @event.photos
    	@tickets = @event.tickets 
    	@user = User.where(id: @referral.order.buyer_id).first
    	@current_purchases = Order.where(referral_id: @referral.id).count
    	@friends_joined = Order.where(referral_id: @referral.id)
    	@bongopass_fee = 3.50 
    	@going = ' is going to '

    	set_meta_tags og: {	  
			title:       @referral.order.first_name + @going + @event.event_title,
			description: @event.event_description.html_safe,
			type:        'article',
			url:         referral_url(@referral),
			image:       @photos[0].image.url(:original),
			app_id:   1870680056482347
        }

	end



	private
	    def set_referral
	      @referral = Referral.find(params[:id])
	    end


	    def is_authorized
      		redirect_to referral_path, alert: "You don't have permission" unless current_user.present? && current_user.id == @referral.order.buyer_id
   		end
	


end

