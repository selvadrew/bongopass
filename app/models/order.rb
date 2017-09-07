class Order < ApplicationRecord
	
	belongs_to :ticket 

	belongs_to :buyer, class_name: "User"
	belongs_to :seller, class_name: "User"

	validates :address, :city, :province, presence: true 
	validate :quantity_available 

	def quantity_available
		if ticket.ticket_quantity == 0 
			self.errors.add(:base, "This ticket has sold out")
		end
	end
	
end
