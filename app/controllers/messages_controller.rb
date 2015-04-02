class MessagesController < ApplicationController

  before_action :authenticate_user

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.contact = Contact.find_or_initialize_by(phone: @message.to)
    @message.contact.user = current_user
    if @message.save
      flash[:notice] = "SMS sent!"
      redirect_to user_contact_path(@message.contact.user, @message.contact)
    else
      flash[:alert] = "Fix the phone number!"
      render :new
    end
  end

private
  def message_params
    params.require(:message).permit(:to, :body).merge(from: ENV['FROM_PHONE_NUMBER'])
  end
end
