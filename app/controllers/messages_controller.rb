class MessagesController < ApplicationController

  before_action :authenticate_user

  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    # @message = Message.new
    unless params[:phone] == nil
      @contact = Contact.find_by(phone: params[:phone])
      render :new_from_existing_phone
    else
      render :new
    end
  end

  def create
    from = ENV['FROM_PHONE_NUMBER']
    body = params[:body]
    recipients = params[:to].split
    stati = []

    recipients.each do |recipient|
      msg = Message.new(from: from, body: body, to: recipient)
      msg.contact = Contact.find_or_initialize_by(phone: msg.to)
      msg.contact.user = current_user
      if msg.save
        stati.push("SMS sent to " + recipient + " successfully!")
      else
        stati.push("SMS failed to " + recipient + ". :(")
      end
    end

    binding.pry
    flash[:notice] = stati
    redirect_to user_path(current_user)
  end

private
  def message_params
    params.require(:message).permit(:to, :body).merge(from: ENV['FROM_PHONE_NUMBER'])
  end
end
