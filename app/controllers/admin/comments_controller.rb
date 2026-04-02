class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post
  before_action :set_comment, only: [:destroy, :edit, :update]

  def destroy
    @comment.destroy
    redirect_to admin_post_path(@post), notice: 'コメントを削除しました。'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
