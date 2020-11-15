class UsersController < ApplicationController
    before_action :authenticate_user!

    def show
        @current = User.find(params[:id])
        @user = User.find(params[:id])
        @soliloquies = @user.soliloquies
        @matchings = current_user.matchers.select { |n| n.id  == params[:id].to_i }

        # binding.pry
    end

    def index
        @users = User.all
        @soliloquies = Soliloquy.all
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
end
