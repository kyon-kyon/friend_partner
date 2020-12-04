class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i(update destroy)
  before_action :authenticate_user!

  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end
end
