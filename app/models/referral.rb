class Referral < ApplicationRecord
  belongs_to :order

  def to_param 
    "#{id}-23-8f46s2-5g029t0p42-join-#{order.first_name.parameterize}"
  end


end

# Check if my order has a referral id in it. If it does, collect all the other times that ID is displayed.
# Check the order of that referral and see if it has someone elses referral id as well 
# Check how many times that referral appears 
# Check if that 


#Check if there is a referral ID in my order 
#If yes, find all the orders with that referral ID
#find the order id of that referral and see if that has a referral 


#Checks my referral ID
#Finds all the orders with my referral ID
#vlookup their names 

