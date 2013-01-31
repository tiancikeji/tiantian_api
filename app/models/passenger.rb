class Passenger < ActiveRecord::Base
  attr_accessible :lat, :lng, :mobile, :name, :password, :iosDevice, :androidDevice, :online 
  acts_as_mappable 
  validates :mobile, :uniqueness => true
  has_many :trips
  has_many :conversations
end
