class Order < ApplicationRecord
	validates :address, :city, :province, presence: true 

	belongs_to :ticket 

	belongs_to :buyer, class_name: "User"
	belongs_to :seller, class_name: "User"
	
end
