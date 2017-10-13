class Ticket < ApplicationRecord
  
  	belongs_to :event, optional: true
  	has_many :orders

	validates :ticket_name, presence: true
	validates :ticket_quantity, presence: true, numericality: {greater_than_or_equal_to: 1}
  	validates :ticket_price, presence: true, numericality: {greater_than_or_equal_to: 1}
  #validates :ticket_description, presence: true
 # validates :ticket_start_date, presence: true
 # validates :ticket_start_time, presence: true
 # validates :ticket_end_date, presence: true
#  validates :ticket_end_time, presence: true

end


#optional: true allows a ticket to be created without an event actually being saved  