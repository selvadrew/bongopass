class Question < ApplicationRecord
  belongs_to :event, optional: true 
end
