require 'apns'
APNS.host = 'gateway.sandbox.push.apple.com'
APNS.pem  = 'dev_ck.pem'
APNS.port = 2195
device_token = 'df7779b1fb6f60b0a4b5a231dfa0d6e5eac93b0812c3472c62c03a5d6f0c4ad6'
APNS.send_notification(device_token, :alert => 'Hello iPhone!', :badge => 1, :sound => 'default',
                                         :other => {:sent => 'with apns gem'})
