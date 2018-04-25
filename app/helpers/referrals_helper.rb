module ReferralsHelper

# currently it is a referral object 
# check if there is a referral id in the order associated with my referral


# does the order have a referral id 
# if yes find the order of that referral id 


def down_level(down, initial)
	@two_level_orders = Order.where(referral_id: down.id)
	if @two_level_orders
		@two_level_orders.each do |downOrder|
			@joined_array.push([downOrder , initial])
			@more_level = downOrder.referral
			down_level(@more_level, downOrder)
		end
	end
end

def before_function(order)
	if order.referral_id
		@referral_obj = Referral.where(id: order.referral_id).first
		@next_order = Order.where(id: @referral_obj.order_id).first
		@referrer = @referral_obj.order
		@invitee = order
		#push me and referrer (I joined the referrer)
		@joined_array.push([@invitee, @referrer])
		#push other people that joined the referrer 
		@other_orders = Order.where(referral_id: order.referral_id)
			@other_orders.each do |others|
				if others != order 
					@other_split = others
					@joined_array.push([@other_split , @referrer])
				
				#find myoos referral object's id
					@two_levels = @other_split.referral
					#give myoos referral object to search and his order object
					down_level(@two_levels, @other_split)
				end
			end

		before_function(@next_order)
	else
		@started_party_array = order
	end
end


def compound_down(order)
	@secondary_referrals = Order.where(referral_id: order.referral.id)
		if @secondary_referrals
			@secondary_referrals.each do |invited|
				@invited_array.push([ invited, order])
				compound_down(invited)
			end
		end

end

def after_function(order, inviter)
	#I invite sindu 
	#primary inviter is me 
	#order is sindu, because the parent block is running friends_joined
	@invited_array.push([order, inviter]) 

	#now check for all the orders with sindus referral id 
	#push all the order objects into the array 
	compound_down(order)

end






end