class PostCommentsController < ApplicationController

    def create
      @soliloquy = Soliloquy.find(params[:soliloquy_id])
      @comment = PostComment.new(post_comment_params)
      @comment.user_id = current_user.id
      @comment.soliloquy_id = @soliloquy.id
      @comment.save
    end

    def destroy
      PostComment.find_by(id: params[:id], post_image_id: params[:post_image_id]).destroy
      redirect_to post_image_path(params[:post_image_id])
    end

      private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
