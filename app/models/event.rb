class Event < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy 
  has_many :tickets, dependent: :destroy
  ## NEEED TO THROW ABORT HERE BECAUSE IF EVENT GETS DELETED IT CANT DELETE THE TICKETS IF IT HAS ORDERS? 
  has_many :orders, :through => :tickets
  has_many :questions, dependent: :destroy 
  has_many :speakers, dependent: :destroy
  has_many :sponsors, dependent: :destroy
  has_many :images, dependent: :destroy


  accepts_nested_attributes_for :tickets, allow_destroy: true
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc {|att| att['registration_question'].blank? }
  accepts_nested_attributes_for :speakers, allow_destroy: true, reject_if: proc {|att| att['speaker_name'].blank? }
  accepts_nested_attributes_for :sponsors, allow_destroy: true, reject_if: proc {|att| att['logo'].blank? }

  geocoded_by :location
  after_validation :geocode #, if: :location_changed? 

  after_validation :check_lat
  after_validation :check_long



  validates :event_title, presence: true, length: {maximum:75}
  validates :location, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :end_date, presence: true
  validates :end_time, presence: true
  validates :event_description, presence: true
  validates :organizer_name, presence: true
  validates :organizer_description, presence: true
  validates :event_type, presence: false
  validates :venue, presence: true
  validates :event_currency, presence: true


  def to_param 
    "#{id}-25-7b509a4-s59i7l86-#{event_title.parameterize}"
  end

  def check_lat
    unless self.latitude
      geocode
    end
  end

  def check_long
    unless self.longitude 
      geocode
    end
  end




end
