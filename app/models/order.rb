class Order < ApplicationRecord
	
	belongs_to :ticket 

	belongs_to :buyer, class_name: "User"
	belongs_to :seller, class_name: "User"

	has_one :referral

	validates :first_name, :last_name, presence: true 
	validate :quantity_available 

	after_create :decrement_quantity
	after_create :create_referral 
	

	def quantity_available
		if ticket.ticket_quantity == 0 
			self.errors.add(:base, "This Pass has sold out")
		end
	end


	def decrement_quantity
		self.ticket.update_attribute("ticket_quantity", (ticket.ticket_quantity - 1))
	end


	def create_referral
      referral = Referral.create(order_id: self.id)
    end


	
end
