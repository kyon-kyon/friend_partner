class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @soliloquy = Soliloquy.find(params[:soliloquy_id])
    @favorite = Favorite.new
    @favorite.user_id = current_user.id
    @favorite.soliloquy_id = @soliloquy.id
    @favorite.save
  end

  def destroy
    @soliloquy = Soliloquy.find(params[:soliloquy_id])
    @favorite = current_user.favorites.find_by(soliloquy_id: @soliloquy.id)
    @favorite.destroy
  end
end
