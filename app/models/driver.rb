class Driver < ActiveRecord::Base
  attr_accessible :car_license, :car_service_number, :car_type, :lat, :lng, :mobile, :name, :password, :rate, :androidDevice, :iosDevice, :online, :status
  acts_as_mappable 
  has_many :conversations
  validates :mobile, :uniqueness => true
end
