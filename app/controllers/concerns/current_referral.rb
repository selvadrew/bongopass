module CurrentReferral 

	private
	def invite_referral 
		session[:referral] = @referral.id 
	end

end