#encoding: utf-8
class Api::PushController < ApplicationController
  def index
    sendno = '3323'
    receiverType = '1' #4 broadcast 1 IMEI
    # receiverValue = "353918050081054"
    receiverValue = params[:device_id]
    txt = params[:txt]
    masterSecret = "226600dd389a295d2b90880b"
    app_key = "1fcf114a7565afe55dd79ea4"
    input = sendno + receiverType + receiverValue + masterSecret
    verificationCode = Digest::MD5.hexdigest(input)
    uri = URI('http://api.jpush.cn:8800/sendmsg/v2/notification')
    res = Net::HTTP.post_form(uri, 'verification_code' => verificationCode,
           'sendno' => sendno,'receiver_type' => receiverType, 'receiver_value' => receiverValue,
            'txt' => txt, 'platform' => 'android', 'app_key' => app_key,
            'time_to_live' => '0')
    logger.info(res.body)
    render :json => res.body
  end
end
