class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
    #saveの前に、一度バリデーションチェックが入る。
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.board
    else
              #backを指定してるので、一つ前の掲示板詳細画面に戻る
      redirect_to :back, flash: {
        comment: comment,
        error_messages: comment.errors.full_messages
      }
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:board_id, :name, :comment)
  end
end
