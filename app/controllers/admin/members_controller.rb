class Admin::MembersController < ApplicationController

  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.order('last_name')
    respond_to do |format|
      format.html
      format.csv { send_as_csv(member_data(@members), "Mitgliederliste.csv") }
    end
  end

  def show
  end

  def edit

  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to admin_members_url, notice: 'Member was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @member.update(member_params)
      redirect_to admin_members_url, notice: 'Member was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    if @member.destroy
      redirect_to admin_members_url, notice: 'Member was successfully destroyed.'
    end
  end


  private

  def set_member
    @member = Member.find params[:id]
  end

  def member_data(members)
    export_attributs =  [:first_name,
                         :last_name,
                         :street,
                         :plz,
                         :city,
                         :mobil,
                         :email,
                         :occurs_at,
                         :birthday]
    members.map do |m|
      export_attributs.map do |p|
        value =  m.send(p)
        value.is_a?(Date) ? value.strftime('%d.%m.%Y') : value
      end
    end.insert(0,export_attributs.map{|a|I18n.t("activerecord.attributes.member.#{a}")})
  end



  def member_params
    params.require(:member).permit(
      :first_name,
      :last_name,
      :street,
      :plz,
      :city,
      :mobil,
      :email,
      :occurs_at,
      :user_id,
      :birthday
    )
  end
end
