class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable ,:omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email 
       user.password = Devise.friendly_token[0,20]
       user.skip_confirmation!
     end
  end

  has_many :created_events, class_name: "Event", foreign_key: :owener_id

end
