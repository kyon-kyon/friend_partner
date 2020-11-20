class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @current = User.find(params[:id])
        @user = User.find(params[:id])
        @soliloquies = @user.soliloquies
        @matchings = current_user.matchers.select { |n| n.id  == params[:id].to_i }
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
