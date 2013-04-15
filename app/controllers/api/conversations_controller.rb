class Api::ConversationsController < ApplicationController
  # GET /conversations
  # GET /conversations.json
  def index
    if params[:to_id]
      @conversations = Conversation.where(:to_id => params[:to_id])
    end
    if params[:from_id]
      @conversations = Conversation.where(:from_id => params[:from_id])
    end
    Conversation.push 
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
	logger.info("------------------------------")
	logger.info(@conversation.from_id)
	if @conversation.status == 1
	  Conversation.where(:from_id => @conversation.from_id).where(:status => 0).each do |conversation|
	    Conversation.update(conversation.id,:status => 5)
	  end
	end

    if @conversation.update_attributes(params[:conversation])
      render :json => { :conversation => @conversation }
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
