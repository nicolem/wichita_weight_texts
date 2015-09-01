class SpanishMessagesController < ApplicationController
  before_action :set_spanish_message, only: [:show, :edit, :update, :destroy]

  # GET /spanish_messages
  # GET /spanish_messages.json
  def index
    @spanish_messages = SpanishMessage.all
  end

  # GET /spanish_messages/1
  # GET /spanish_messages/1.json
  def show
  end

  # GET /spanish_messages/new
  def new
    @spanish_message = SpanishMessage.new
  end

  # GET /spanish_messages/1/edit
  def edit
  end

  # POST /spanish_messages
  # POST /spanish_messages.json
  def create
    @spanish_message = SpanishMessage.new(spanish_message_params)

    respond_to do |format|
      if @spanish_message.save
        format.html { redirect_to @spanish_message, notice: 'Spanish message was successfully created.' }
        format.json { render :show, status: :created, location: @spanish_message }
      else
        format.html { render :new }
        format.json { render json: @spanish_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spanish_messages/1
  # PATCH/PUT /spanish_messages/1.json
  def update
    respond_to do |format|
      if @spanish_message.update(spanish_message_params)
        format.html { redirect_to @spanish_message, notice: 'Spanish message was successfully updated.' }
        format.json { render :show, status: :ok, location: @spanish_message }
      else
        format.html { render :edit }
        format.json { render json: @spanish_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spanish_messages/1
  # DELETE /spanish_messages/1.json
  def destroy
    @spanish_message.destroy
    respond_to do |format|
      format.html { redirect_to spanish_messages_url, notice: 'Spanish message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spanish_message
      @spanish_message = SpanishMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
 def spanish_message_params
      params.require(:spanish_message).permit(
        :id, :text
      )
    end
end
