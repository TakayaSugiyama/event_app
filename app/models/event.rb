class Event < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :place, presence: true, length: {maximum: 100}
  validates :content, presence: true , length: {maximum:2000}
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_should_be_before_end_time
  
  has_many :tickets
  has_many :participant,source: :user, class_name: "Ticket"
  #has_many :participants, through: :tickets, source: :user

  belongs_to :owner, class_name: 'User'

  def created_by?(user)
    false unless user 
    self.owner == user
  end

  private 

  def start_time_should_be_before_end_time 
    return unless start_time  &&  end_time
    if start_time >= end_time
       errors.add(:start_time, "は終了時間よりも前に設定してください")
    end
  end
end
