class SoliloquiesController < ApplicationController
    def top
    end

    def about
    end

    def index
        @users = User.all
        @soliloquies = Soliloquy.all
        @post_comment = PostComment.new
    end

    def new
        @soliloquy = Soliloquy.new
    end

    def create
        @soliloquy = Soliloquy.new(soliloquy_params)
        @soliloquy.user_id = current_user.id
        if @soliloquy.save
            redirect_to soliloquy_path(@soliloquy)
        else
            render :new
        end

    end

    def show
        @soliloquy = Soliloquy.find(params[:id])
        @post_comment = PostComment.new

    end

   private

   def soliloquy_params
       params.require(:soliloquy).permit(:title, :object, :what_do, :how_feel, :must_do, :did_action, :purpose_soliloquy)
   end
end
