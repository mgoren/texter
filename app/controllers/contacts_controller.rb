class ContactsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @contacts = @user.contacts
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    @user = current_user
    if @contact.save
      flash[:notice] = "Contact saved!"
      redirect_to user_contacts_path(current_user)
    else
      flash[:alert] = "Some kind of error."
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

private
  def contact_params
    params.require(:contact).permit(:name, :phone)
  end

end
