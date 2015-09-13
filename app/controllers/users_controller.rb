class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(id: :ASC)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @histories = @user.histories.order(created_at: :DESC)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    @user.phone = PhonyRails.normalize_number(params[:user][:phone], :country_code => 'US')
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.update(user_params)
    @user.phone = PhonyRails.normalize_number(params[:user][:phone], :country_code => 'US')
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def reply
    logger.debug "inside reply function"
    sender = params[:From]
    user = User.find_by(:phone => sender)
    response = Twilio::TwiML::Response.new do |r|
      if user.nil?
        r.Message "Thank you for participating in research, but this account is not monitored for replies.  Please contact the researcher if you have any questions."
      else 
        if user.language == English
          r.Message "Thank you for participating in research, but this account is not monitored for replies.  Please contact the researcher if you have any questions."
        else
          r.Message "Gracias por participar en la investigacion, pero esta cuenta no se supervisa para las respuestas . Por favor, pongase en contacto con el investigador si tiene alguna pregunta ."
        end
      end
      
    end
    render_twiml response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
    params.require(:user).permit(
      :id, :phone, :active, :language, :next_message
    )
    end
end
