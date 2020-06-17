class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]
  
  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end

  def new
    @board = Board.new
  end

  def create
    board = Board.new(board_params)
    if board.save
       flash[:notice] = "「#{board.title}」の掲示板を作成しました"
       redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show
    #この書き方なら、コメントモデルからnewで作成する際board_idをセットして初期化しているので、@boardに紐づいたcommentsには影響しない..??は？
    @comment = Comment.new(board_id: @board.id)
   # @comment = @board.comments.new
   #@board.comments.newにすると、保存されていない状態のコメントが、@board.commentsに含まれてしまう。
  end


  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to @board
    else
      redirect_to :back, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
  end

  def destroy
   @board.destroy
#@board.deleteからdestroyへ(lecture75. dependent: :delete_allにならって。掲示板を消したら、コメントとタグの関連データも消えるようになる
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました" }

  end
  private

  def board_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
  end
  
  def set_target_board
    @board = Board.find(params[:id])
  end
end
