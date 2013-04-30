class PygmentsWorker
  include Sidekiq::Worker
  # sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(convers)
    convers.each do |con|
      if con.status == STATUS_NEW
        Conversation.update(con.id,:status => 5)
        logger.info("=========timer update status ================")
      end
    end

  end
end
