class Ticket < ApplicationRecord
  
  belongs_to :event, optional: true
  has_many :orders
  	
end


#optional: true allows a ticket to be created without an event actually being saved  