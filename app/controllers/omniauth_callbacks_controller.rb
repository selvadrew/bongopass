class OmniauthCallbacksController < Devise::OmniauthCallbacksController

#FACEBOOK AUTHENTICATION
	def facebook 
		@user = User.from_omniauth(request.env["omniauth.auth"])
		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication 
			set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url 
		end
	end

	def failure
   		redirect_to root_path
  	end

#GOOGLE AUTHENTICATION
	def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
  	end


#STRIPE AUTHENTICATION
#=begin
	def stripe_connect
		auth_data = request.env["omniauth.auth"]
		@user = current_user 

		if @user.persisted?
			@user.merchant_id = auth_data.uid 
			@user.save

			if !@user.merchant_id.blank?
				account = Stripe::Account.retrieve(current_user.merchant_id)
				#account.payout_schedule.delay = 7 
				#account.payout_schedule.interval = 'daily'

				#account.payout_schedule.monthly_anchor = 15
				#account.payout_schedule.interval = 'monthly'
				account.save

				logger.debug "#{account}"
			end

			sign_in_and_redirect @user, event: :authentication
			flash[:notice] = "Stripe account created and connected" if is_navigational_format?

		else 
			session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
			redirect_to dashboard_path
		end
	end

#=end







end























