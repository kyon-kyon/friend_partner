class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  def new_guest
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストユーザーとしてログインしました。'
  end
end
