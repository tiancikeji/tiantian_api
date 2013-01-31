class Trip < ActiveRecord::Base
  attr_accessible :appointment, :end, :start, :passenger_id, :start_lat, :start_lng, :end_lat, :end_lng
  belongs_to :passenger
  has_many :conversations
end
