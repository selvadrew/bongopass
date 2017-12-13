class Referral < ApplicationRecord
  belongs_to :order

  def to_param 
    "#{id}-23-8f46s2-5g029t0p42-join-#{order.first_name.parameterize}"
  end

end
