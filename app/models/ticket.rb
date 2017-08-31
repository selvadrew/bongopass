class Ticket < ApplicationRecord
  belongs_to :event, optional: true
  	#optional: true allows a ticket to be created without an event actually being saved  
end
