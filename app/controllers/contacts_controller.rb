class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to root_url, notice: 'Nachricht wurde versendet'
    else
      render action: 'new'
    end
  end

  protected

    def contact_params
      params.require(:contact).permit(:name, :email, :subject, :body)
    end
end
