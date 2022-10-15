class CommentsController < ApplicationController
  before_action :comment_params, only: %i[ create show edit ]
  # POST /comments or /comments.json

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user)
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render template: 'posts/show'  #render先にjsファイルを指定
    else
      flash[:danger] = "投稿に失敗しました"
      render template: 'posts/show'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to root_path(@post), notice: "コメントを編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render 'edit'
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.Comment.find(params[:id])
    @comment.destroy
    flash[:danger] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # 信頼できるパラメータのリストのみ通過させる。
    # item_id: params[:post_id]で値を入れることができるのは、ルーティングをネストし、URLにpost_idを含めているため。
    # ストロングパラメーターはprivateメソッド以下に記述する。

    # requireの引数は、モデル名。
    # permitの引数は、DBのカラム名。
    def comment_params
      params.permit(:titile, :body).merge(user_id: current_user.id, post_id: params[:post_id])
    end
end
