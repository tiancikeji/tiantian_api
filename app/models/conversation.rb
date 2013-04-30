#encoding: utf-8
require 'timers'
class Conversation < ActiveRecord::Base
  STATUS_NEW = 0
  STATUS_ACCETP = 1
  STATUS_REJECT = 2
  STATUS_NEW_DESC = 'new'
  STATUS_ACCETP_DESC = 'accept'
  STATUS_REJECT_DESC = 'reject'
  attr_accessible :from_id, :status, :status_desc, :to_id, :trip_id, :content, :left
  belongs_to :trip
  belongs_to :passenger ,:class_name => 'Passenger', :foreign_key => 'from_id'
  belongs_to :driver, :class_name => 'Driver', :foreign_key => 'to_id'

  def self.scope(trip, drivers)
    convers = []
    drivers.each  do | driver|
      new_conversation = Conversation.create(:from_id => trip.passenger_id, :to_id => driver.id, :status => STATUS_NEW, 
                          :status_desc => STATUS_NEW_DESC, :trip_id => trip.id , :content => 'a passenger want a car')
      convers << new_conversation
      Conversation.notice("driver_"+driver.id.to_s,"conversations")
    end
    timers = Timers.new
    timers.after(90){
      convers.each do |con|
        if con.status == STATUS_NEW
	  Conversation.update(con.id,:status => 5)
          Conversation.notice("driver_"+con.to_id.to_s,"conversations")
          logger.info("=========timer update status ================")
        end
      end
    }
    timers.wait
  end

  def self.single(trip,driver)
      Conversation.create(:from_id => trip.passenger_id, :to_id => driver.id, :status => STATUS_NEW, 
                          :status_desc => STATUS_NEW_DESC, :trip_id => trip.id , :content => 'a passenger want a car')
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
    @distance = '5'
  end

end
