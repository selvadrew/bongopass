class Event < ApplicationRecord
  belongs_to :user

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
