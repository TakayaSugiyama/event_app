class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i(github)

  has_many :tickets
  has_many :events, through: :tickets

  has_many :created_events, class_name: 'Event', foreign_key: :owner_id
  before_destroy :check_all_events_finished

  before_destroy :user_id_to_nil

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.nickname
      user.password = Devise.friendly_token[0, 20]
      user.profile_image = 'default.jpg'
      user.image = auth.info.image
      user.skip_confirmation!
    end
  end

  def github_user?
    provider.nil? ? false : true
  end

  private

  def check_all_events_finished
    now = Time.zone.now
    if created_events.where(':now < end_time', now: now).exists?
      errors[:base] << '公開中の未終了イベントが存在します。'
    end

    if events.where(':now < end_time', now: now).exists?
      errors[:base] << '未終了の参加イベントが存在します。'
    end
    throw :abort unless errors.blank?
  end

  def user_id_to_nil
    tickets.update_all(user_id: nil)
  end
end
