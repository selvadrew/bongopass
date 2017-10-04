class Image < ActiveRecord::Base
	attachment :image, type: :image
 	belongs_to :event, optional: true 
end
