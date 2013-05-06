class PygmentsWorker
  include Sidekiq::Worker
  # sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(convers)
    logger.info("=========sidekiq update status ================")
    logger.info(convers.count)
    logger.info(convers)
    convers.each do |id|
      logger.info(id)
      con =  Conversation.find(id)
      if con.status == 0
        Conversation.update(con.id,:status => 5)
      	Conversation.notice("driver_"+con.to_id.to_s,"conversations")
      end	
    end
  end

end
