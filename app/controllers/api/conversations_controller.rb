class Api::ConversationsController < ApplicationController
  STATUS_ACCEPT = 1
  STATUS_RIDER_CANCEL = -1
  STATUS_DRIVER_CANCEL = 2
  STATUS_FINISH = 4
  STATUS_OVER = 5

  HTTP_SUCCESS = 200
  HTTP_UPDATE_CONFLICT = 409

  ALREADY_ACCEPTED = 0
  RIDER_CANCELED = 1

  # GET /conversations
  # GET /conversations.json
  def index
    if params[:to_id]
      @conversations = Conversation.where(:to_id => params[:to_id])
    end
    if params[:from_id]
      if params[:only_not_finished]
      	@conversations = Conversation.where("from_id = "+params[:from_id]+" and status <> 5 ")
      else 
      	@conversations = Conversation.where(:from_id => params[:from_id])
      end
    end
    if params[:trip_id]
      @conversations = Conversation.where(:trip_id => params[:trip_id])
    end
    render :json => {:conversations => @conversations }
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.find(params[:id])
    render :json => {:conversation => @conversation }
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    @conversation = Conversation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @conversation = Conversation.find(params[:id])
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(params[:conversation])

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render json: @conversation, status: :created, location: @conversation }
      else
        format.html { render action: "new" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /conversations/1
  # POST /conversations/1.json
  def update
    @conversation = Conversation.find(params[:id])

    #A driver is trying to accept a trip, we must check to make sure the trip hasn't already been
    #accepted or canceled but the driver hasn't received this update due to network latency
    if STATUS_ACCEPT.to_s == params[:conversation][:status]
      if STATUS_ACCEPT == @conversation.status || STATUS_OVER == @conversation.status
        render :json => { :status => HTTP_UPDATE_CONFLICT, :reason => ALREADY_ACCEPTED }
        return
      end
      if STATUS_RIDER_CANCEL == @conversation.status
        render :json => { :status => HTTP_UPDATE_CONFLICT, :reason => RIDER_CANCELED}
        return
      end
    end

    @conversation.status = params[:conversation][:status]

    if @conversation.status == 0 or @conversation.status == 4
      Conversation.notice("passenger_"+@conversation.from_id.to_s,"conversations")
      Apn.send(@converstaion.from.iosDevice,"converstaion")
    end

    #Don't send a push to the driver, he/she will receive a notice if the update fails
    if STATUS_ACCEPT == @conversation.status or STATUS_DRIVER_CANCEL == @conversation.status
      Conversation.notice("passenger_"+@conversation.from_id.to_s,"conversations")
      Apn.send(@conversation.passenger.iosDevice,"converstaion")
    elsif STATUS_RIDER_CANCEL == @conversation.status
      Conversation.notice("driver_"+@conversation.to_id.to_s,"conversations")
    end

    if @conversation.status == 1 or @conversation.status == -1 or @conversation.status == 2
      Conversation.where("from_id = "+@conversation.from_id.to_s+" and id <> "+params[:id]+" and status <> 5 ").each do |conversation|
        Conversation.notice("driver_"+conversation.to_id.to_s,"conversations")
        Conversation.update(conversation.id,:status => 5)
      end

    end

    if @conversation.update_attributes(params[:conversation])
      render :json => { :status => HTTP_SUCCESS, :conversation => @conversation }
    else
      render json: @conversation.errors, status: :unprocessable_entity 
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :no_content }
    end
  end
end
