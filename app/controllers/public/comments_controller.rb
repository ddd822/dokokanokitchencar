class Public::CommentsController < ApplicationController
  before_action :authenticate_shop!, if: -> { shop_signed_in? }
    before_action :authenticate_customer!, if: -> { customer_signed_in? }
    before_action :set_post
    before_action :set_comment, only: [:destroy]
    before_action :authorize_comment!, only: [:destroy]

    def create
      @comment = @post.comments.build(comment_params)
      @comment.user = current_shop || current_customer

      if @comment.save
        redirect_to post_path(@post), notice: 'コメントを投稿しました。'
      else
        redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました。'
      end
    end

    def destroy
      @comment.destroy
      redirect_to post_path(@post), notice: 'コメントを削除しました。'
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end

    def authorize_comment!
      unless @comment.user == current_shop || @comment.user == current_customer
        redirect_to post_path(@post), alert: 'コメントの削除権限がありません。'
      end
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
