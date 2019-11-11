class Event < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :place, presence: true, length: {maximum: 100}
  validates :content, presence: true , length: {maximum:2000}
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :start_time_should_be_before_end_time

  private 

  def start_time_should_be_before_end_time 
    return unless start_time && end_time
    if start_time >= end_time
       errors.add(:start_time, "終了時間よりも前に設定してください")
    end
  end
end
