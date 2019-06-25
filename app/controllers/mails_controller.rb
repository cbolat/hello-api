class MailsController < ApplicationController
  before_action :set_mail, only: [:show, :update, :destroy]

  # GET /mails
  def index
    @mails = Mail.all

    render json: @mails
  end

  # GET /mails/1
  def show
    render json: @mail
  end

  # POST /mails
  def create
    @mail = Mail.new(mail_params)

    if @mail.save
      render json: @mail, status: :created, location: @mail
    else
      render json: @mail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mails/1
  def update
    if @mail.update(mail_params)
      render json: @mail
    else
      render json: @mail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /mails/1
  def destroy
    @mail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail
      @mail = Mail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mail_params
      params.require(:mail).permit(:name, :email)
    end
end
