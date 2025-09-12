class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[
    edit
    show
    destroy
    update
  ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_url, notice: "User was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_root_path, notice: "The account was successfully updated."
    else
      flash[:alert] = "Account not updated."
      render :edit
    end
  end

  def destroy
    if current_user == @user
      flash[:alert] = "Sich selbst kann man nicht löschen"
      redirect_to admin_users_url
    else
      @user.destroy
      redirect_to admin_users_url, notice: "User was successfully destroyed."
    end
  end

  private

  def set_user
    @user = User.friendly.find params[:id]
  end

  def user_params
    permitted_params = %i[username email_address password password_confirmation]
    permitted_params << :admin if Current.user&.admin?
    params.expect(user: [permitted_params])
  end
end
