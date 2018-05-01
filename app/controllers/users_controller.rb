class UsersController < ApplicationController 
	before_action :authenticate_user!, only: [:paypal_payout]
	before_action :set_user, only: [:community]

	def show 
		@user = User.find(params[:id])
	end

	def payout
		Stripe.api_key = ENV["STRIPE_API_KEY"]
		if !current_user.merchant_id.blank?
			account = Stripe::Account.retrieve(current_user.merchant_id)
		end
	end

	def create
	    # Create the user from params
	    @user = User.new(params[:user])
	    if @user.save
	      # Deliver the signup email
	      UserNotifier.send_signup_email(@user).deliver
	      redirect_to(@user, :notice => 'User created')
	    else
	      render :action => 'new'
	    end
  	end


  	def community 
  		@user = User.find(params[:id])

  	end


  private
    def set_user
      @user = User.find(params[:id])
    end



end