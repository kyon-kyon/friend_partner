class PostCommentsController < ApplicationController

    def create
      @soliloquy = Soliloquy.find(params[:soliloquy_id])
      @post_comment = PostComment.new(post_comment_params)
      @post_comment.user_id = current_user.id
      @post_comment.soliloquy_id = @soliloquy.id
      @post_comment.save
      @post_comment = PostComment.new
      #redirect_to soliloquy_path(@soliloquy)
    end

    def destroy
      @soliloquy = Soliloquy.find(params[:soliloquy_id])
      @post_comment = PostComment.find_by(id: params[:id], soliloquy_id: params[:soliloquy_id])
      @post_comment.destroy
      @post_comment = PostComment.new
      #redirect_to soliloquy_path(@soliloquy)

    end

      private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
