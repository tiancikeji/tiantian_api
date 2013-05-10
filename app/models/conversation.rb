#encoding: utf-8

class Conversation < ActiveRecord::Base
  STATUS_NEW = 0
  STATUS_ACCETP = 1
  STATUS_REJECT = 2
  STATUS_NEW_DESC = 'new'
  STATUS_ACCETP_DESC = 'accept'
  STATUS_REJECT_DESC = 'reject'
  attr_accessible :from_id, :status, :status_desc, :to_id, :content, :left, :appointment, :end, :start, :passenger_id, :start_lat, :start_lng, :end_lat, :end_lng, :price, :trip_id, :mobile
 
#  belongs_to :trip
  belongs_to :passenger ,:class_name => 'Passenger', :foreign_key => 'from_id'
  belongs_to :driver, :class_name => 'Driver', :foreign_key => 'to_id'

  def self.scope(trip, drivers)
    convers = []
    drivers.each  do | driver|
      # duplicating passenger id, for clarity, also keeping trip_id
      #relation in place in case we need it for future use
      new_conversation = Conversation.create(:from_id => trip.passenger_id, :to_id => driver.id, :status => STATUS_NEW, :appointment => trip.appointment, 
	:trip_id => trip.id, :mobile => trip.passenger.mobile,
	:end => trip.end, :start => trip.start, :passenger_id => trip.passenger_id,
	:start_lat => trip.start_lat, :start_lng => trip.start_lng,
	:end_lng => trip.end_lng, :end_lat => trip.end_lat, :price => trip.price,
        :status_desc => STATUS_NEW_DESC, :content => 'a passenger want a car')
      convers << new_conversation.id
      Conversation.notice("driver_"+driver.id.to_s,"conversations")# new_conversation.to_json )
    end
     PygmentsWorker.perform_in(90, convers)
  end

  def self.single(driver)
      Conversation.create(:from_id => trip.passenger_id, :to_id => driver.id, :status => STATUS_NEW, :appointment => trip.appointment, 
	:end => trip.end, :start => trip.start, :passenger_id => trip.passenger_id, :mobile => trip.passenger.mobile,
	:start_lat => trip.start_lat, :start_lng => trip.start_lng,
	:end_lng => trip.end_lng, :end_lat => trip.end_lat, :price => trip.price,
                          :status_desc => STATUS_NEW_DESC , :content => 'a passenger want a car')
  end

  def self.notice(alias_name,txt)
    sendno = '3323'
    receiverType = '3' #4 broadcast 1 IMEI
    receiverValue = alias_name
    masterSecret = "226600dd389a295d2b90880b"
    app_key = "1fcf114a7565afe55dd79ea4"
    input = sendno + receiverType + receiverValue + masterSecret
    verificationCode = Digest::MD5.hexdigest(input)
    uri = URI('http://api.jpush.cn:8800/sendmsg/v2/notification')
    res = Net::HTTP.post_form(uri, 'verification_code' => verificationCode,
           'sendno' => sendno,'receiver_type' => receiverType, 'receiver_value' => receiverValue,
            'txt' => txt, 'platform' => 'android', 'app_key' => app_key,
            'time_to_live' => '0')
	logger.info("push server-------------->")
	logger.info(alias_name)
    logger.info(res.body)
  end

  def left
    @left =  (Time.now - self.created_at).to_i
  end
 
  def distance
    driver = Driver.find(self.to_id)
    passenger = Passenger.find(self.from_id)
    @distance = GeoKit::LatLng.new(driver.lat,driver.lng).distance_from(GeoKit::LatLng.new(passenger.lat,passenger.lng))
  end

end
