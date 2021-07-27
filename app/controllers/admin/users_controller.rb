class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [
    :edit,
    :show,
    :destroy,
    :update
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
    new_params = user_params.dup
    new_params[:username] = new_params[:username].strip
    new_params[:email] = new_params[:email].strip
    if @user.update(new_params)
      redirect_to admin_root_path, notice: "the account was successfully updated."
    else
      flash[:alert] = "Account not updated."
      render :edit
    end
  end

  def destroy
    if current_user != @user
      @user.destroy
      redirect_to admin_users_url, notice: "User was successfully destroyed."
    else
      flash[:alert] = "Sich selbst kann man nicht löschen"
      redirect_to admin_users_url
    end
  end

  private

  def set_user
    @user = User.friendly.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :admin,
      :password,
      :password_confirmation
    )
  end
end
