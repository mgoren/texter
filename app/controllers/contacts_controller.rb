class ContactsController < ApplicationController

  before_action :authenticate_user

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

    @contact.normalize_phone_number
    existing_contact = @user.contacts.find_by(phone: @contact.phone)

    if existing_contact
      flash[:alert] = "This contact is already in your phone book!"
      render 'new'
    else
      if @contact.save
        flash[:notice] = "Contact saved!"
        redirect_to user_path(current_user)
      else
        flash[:alert] = "Some kind of error."
        render 'new'
      end
    end
    
  end

  def edit
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def update
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])
    if @contact.update(contact_params)
      flash[:notice] = @contact.name + " has been successfully edited."
      redirect_to user_contact_path(@user, @contact)
    else
      render "edit"
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @user = User.find(params[:user_id])
    flash[:notice] = @contact.name + " has been deleted from your life."
    @contact.destroy
    redirect_to user_path(@user)
  end

private
  def contact_params
    params.require(:contact).permit(:name, :phone, :avatar)
  end

end
