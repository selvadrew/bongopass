class Photo < ApplicationRecord
  belongs_to :event, optional: true 

  has_attached_file :image, styles: { medium: "725x365>",  thumb: "100x100>" }#, default_url: "https://drscdn.500px.org/photo/231048293/q%3D80_m%3D1500_k%3D1/v2?webp=true&sig=af92c96f987e3d711bb7ba4c710801bd92f11525251d54991665131da29833a9"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

 
end
