class FavoritesController < ApplicationController
  def create
    @soliloquy = Soliloquy.find(params[:soliloquy_id])
    @favorite = Favorite.new
    @favorite.user_id = current_user.id
    @favorite.soliloquy_id = @soliloquy.id
    @favorite.save
    #redirect_to soliloquy_path(@soliloquy)
  end

  def destroy
    @soliloquy = Soliloquy.find(params[:soliloquy_id])
    # @favorite = Favorite.find_by(soliloquy_id: @soliloquy.id)
    # @favorite.user_id = current_user.id
    # @favorite.soliloquy_id = @soliloquy.id
    @favorite = current_user.favorites.find_by(soliloquy_id: @soliloquy.id)
    @favorite.destroy
    #redirect_to soliloquy_path(@soliloquy)
  end
end
