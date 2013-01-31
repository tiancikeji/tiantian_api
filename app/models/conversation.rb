class Conversation < ActiveRecord::Base
  STATUS_NEW = 0
  STATUS_ACCETP = 1
  STATUS_REJECT = 2
  STATUS_NEW_DESC = 'new'
  STATUS_ACCETP_DESC = 'accept'
  STATUS_REJECT_DESC = 'reject'
  attr_accessible :from_id, :status, :status_desc, :to_id, :trip_id, :content
  belongs_to :trip
  belongs_to :passenger ,:class_name => 'Passenger', :foreign_key => 'from_id'
  belongs_to :driver, :class_name => 'Driver', :foreign_key => 'to_id'

  def self.scope(trip, drivers)
    drivers.each  do | driver|
      Conversation.create(:from_id => trip.passenger_id, :to_id => driver.id, :status => STATUS_NEW, 
                          :status_desc => STATUS_NEW_DESC, :trip_id => trip.id , :content => 'a passenger want a car')
    end
  end

  def self.single(trip,driver)
      Conversation.create(:from_id => trip.passenger_id, :to_id => driver.id, :status => STATUS_NEW, 
                          :status_desc => STATUS_NEW_DESC, :trip_id => trip.id , :content => 'a passenger want a car')
  end

end
