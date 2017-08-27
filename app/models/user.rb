class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # added confirmable because we didnt have this option before 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :confirmable, :omniauthable

  validates :fullname, presence: true, length: {maximum: 50}

  def self.from_omniauth(auth)
  	user = User.where(email: auth.info.email).first

  	if user 
  		return user 
  	else 
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  			user.fullname = auth.info.name
  			user.provider = auth.provider
  			user.uid = auth.uid 
  			user.email = auth.info.email 
  			user.image = auth.info.image
  			user.password = Devise.friendly_token[0,20]
  			#user.skip_confirmation!
  			end
		end
	end


	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end
