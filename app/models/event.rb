class Event < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy 
  has_many :tickets, dependent: :destroy 
  ## NEEED TO THROW ABORT HERE BECAUSE IF EVENT GETS DELETED IT CANT DELETE THE TICKETS IF IT HAS ORDERS? 
  has_many :orders, :through => :tickets  
  has_many :questions, dependent: :destroy 
  has_many :speakers, dependent: :destroy
  has_many :sponsors, dependent: :destroy

  accepts_nested_attributes_for :tickets, allow_destroy: true, reject_if: proc {|att| att['ticket_name'].blank? }
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc {|att| att['registration_question'].blank? }
  accepts_nested_attributes_for :speakers, allow_destroy: true, reject_if: proc {|att| att['speaker_name'].blank? }
  accepts_nested_attributes_for :sponsors, allow_destroy: true, reject_if: proc {|att| att['logo'].blank? }

  geocoded_by :location
  after_validation :geocode, if: :location_changed? 


  validates :event_title, presence: true, length: {maximum:50}
  validates :location, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :end_date, presence: true
  validates :end_time, presence: true
  validates :event_description, presence: true
  validates :organizer_name, presence: true
  validates :organizer_description, presence: true
  validates :event_type, presence: true

 



end
