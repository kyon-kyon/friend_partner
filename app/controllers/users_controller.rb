class UsersController < ApplicationController
    before_action :authenticate_user!

    def quit

    end

    def out
        @user = current_user
        @user.update(is_deleted: "Invaild")
        reset_session
        flash[:notice] = "退会完了しました"
        redirect_to root_path
    end

    def show
        # @current = User.find(params[:id])
        @user = User.find(params[:id])
        if @user.is_deleted == "Invaild"

            flash[:notice] = "退会したユーザーです"
            redirect_to root_path
        else

            @soliloquies = @user.soliloquies


            @currentUserEntry=Entry.where(user_id: current_user.id)
            @userEntry=Entry.where(user_id: @user.id)

            if @user.id == current_user.id
            else
              @currentUserEntry.each do |cu|
                @userEntry.each do |u|
                  if cu.room_id == u.room_id then
                    @isRoom = true
                    @roomId = cu.room_id
                  end
                end
              end
              if @isRoom
              else
                @room = Room.new
                @entry = Entry.new
              end
            end
        end
    end

    def edit
        @user = User.find(params[:id])
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
       @titile = "following"
       @user = User.find(params[:id])
       @users = @user.following.paginate(page: params[:page])
   end

   def followers
       @title = "followers"
       @user = User.find(params[:id])
       @users = @user.followers.paginate(page: params[:page])
   end

   def first
       @users = current_user.matchers
   end

   def new_guest
      @user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      @user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
   end
      sign_in @user
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
   end

   private
   def user_params
       params.require(:user).permit(:last_name, :first_name, :kana_last_name, :kana_first_name,
                                    :email, :encrypted_password, :profile_image, :introduction,
                                    :for_what_application, :message_level, :ignore_character, :occupation,
                                    :think_to_job, :want_job_time, :think_job_relationship, :can_offer_job,
                                    :target_income, :what_want_learn, :like_other_job, :what_desire_love,
                                    :how_did_life, :past_failures, :basic_experience, :what_require,
                                    :my_personality, :can_offer_personality, :request_relationship_spirit,
                                    :interested_by_given)
   end
end
