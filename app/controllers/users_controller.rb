class UsersController < ApplicationController
  before_action :authenticate_user!

  def quit
    @user = User.find(params[:id])
    if @user == User.guest
      flash[:notice] = "ゲストログインはユーザー情報を編集できません"
      redirect_to user_path
    end
  end

  def out
    @user = current_user
    @user.update(is_deleted: "Invaild")
    reset_session
    flash[:notice] = "退会完了しました"
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
    if @user.is_deleted == "Invaild"
      flash[:notice] = "退会したユーザーです"
      redirect_to root_path
    else

      @soliloquies = @user.soliloquies

      @current_user_entry = Entry.where(user_id: current_user.id)
      @user_entry = Entry.where(user_id: @user.id)

      if @user.id == current_user.id
      else
        @current_user_entry.each do |cu|
          @user_entry.each do |u|
            if cu.room_id == u.room_id
              @is_room = true
              @room_id = cu.room_id
            end
          end
        end
        if @is_room
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではない"
      redirect_to user_path
    elsif @user == User.guest
      flash[:notice] = "ゲストログインはユーザー情報を編集できません"
      redirect_to user_path
    else

    end
  end

  def index
    @users = User.all
    @soliloquies = Soliloquy.all
  end

  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではありません"
      redirect_to user_path(current_user.id)
    end
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を変更完了しました"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def following
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name,
                                 :kana_last_name, :kana_first_name,
                                 :email, :encrypted_password,
                                 :profile_image, :introduction,
                                 :for_what_application,
                                 :message_level, :ignore_character,
                                 :occupation, :think_to_job,
                                 :want_job_time, :think_job_relationship,
                                 :can_offer_job, :target_income,
                                 :what_want_learn, :like_other_job,
                                 :what_desire_love, :how_did_life,
                                 :past_failures, :basic_experience,
                                 :what_require, :my_personality,
                                 :can_offer_personality,
                                 :request_relationship_spirit,
                                 :interested_by_given)
  end
end
