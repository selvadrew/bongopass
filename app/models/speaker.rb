class Speaker < ApplicationRecord
  belongs_to :event, optional: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" } #,default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :speaker_name, presence: true
  validates :description, presence: false
end
