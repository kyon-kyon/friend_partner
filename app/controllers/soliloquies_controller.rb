class SoliloquiesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show]

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
    @soliloquy.score = Language.get_data(soliloquy_params[:object])
    @soliloquy.title_score = Language.get_data(soliloquy_params[:title])
    @soliloquy.what_do_score = Language.get_data(soliloquy_params[:what_do])
    @soliloquy.how_feel_score = Language.get_data(soliloquy_params[:how_feel])
    @soliloquy.must_and_can_score = Language.get_data(soliloquy_params[:must_and_can])
    @soliloquy.did_action_score = Language.get_data(soliloquy_params[:did_action])
    @soliloquy.porpose_soliloquy_score = Language.get_data(soliloquy_params[:purpose_soliloquy])

    @soliloquy.user_id = current_user.id
    if @soliloquy.save
      redirect_to soliloquy_path(@soliloquy)
    else
      render :new
    end
  end

  def destroy
    @soliloquy = Soliloquy.find(params[:id])
    @soliloquy.user_id = current_user.id
    @soliloquy.destroy
    redirect_to soliloquies_path
  end

  def show
    @soliloquy = Soliloquy.find(params[:id])
    if @soliloquy.user.is_deleted == "Invaild"
      flash[:notice] = "退会したユーザーの投稿です"
      redirect_to soliloquies_path
    end
    @post_comment = PostComment.new
  end

  private

  def soliloquy_params
    params.require(:soliloquy).permit(:title, :object, :what_do, :how_feel,
                                      :must_and_can, :did_action, :purpose_soliloquy)
  end
end
