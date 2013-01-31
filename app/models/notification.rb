require 'digest/md5'
class Notification < ActiveRecord::Base
  attr_accessible :content, :from_id, :to_id
end
