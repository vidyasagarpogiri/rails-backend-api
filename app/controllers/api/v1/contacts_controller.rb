class Api::V1::ContactsController < ApplicationController
  before_action :authenticate_user!
  def index
    # byebug
    @contacts = current_user.contacts
    render json: @contacts, status: :ok
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    @contact.save
    render json: @contact, status: :created
  end

  def destroy
    @contact = current_user.contacts.where(id: params[:id]).first
    if @contact.destroy
      head(:ok)
    else
      head(:unprocessable_entity)
    end

  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email)
    end
end
