class Admin::ContactsController < Admin::BaseController
  before_action :set_contact, only: [:show]

  # GET /admin/contacts
  def index
    @contacts = Contact.order("created_at desc").paginate page: params[:page], per_page: 20
  end

  # GET /admin/contacts/1
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end
end
