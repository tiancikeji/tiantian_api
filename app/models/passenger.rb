class Passenger < ActiveRecord::Base
  attr_accessible :lat, :lng, :mobile, :name, :password, :iosDevice, :androidDevice, :online 
  acts_as_mappable 
  validates :mobile, :uniqueness => true
  has_many :trips
  has_many :conversations


  def self.send_sms(mobile,content)
    uri = URI.parse("http://www.smsbao.com/sms?u=fpwang&p="+Digest::MD5.hexdigest("tiantiandache")+"&m="+mobile+"&c="+content) 
    http = Net::HTTP.new(uri.host,uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response  = http.request(request)
    raw_info = response.body
    logger.info(raw_info)
    return raw_info 
  end
end
