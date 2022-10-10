class CommentsController < ApplicationController
  # POST /comments or /comments.json
  def create! # #createの後ろに"!"
    binding.pry #データを保存するメソッドの中でデバッグ実行
    @comment = Comment.create(comment_params)
    redirect_to "/posts/#{comment.post.id}"

  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to posts_path(@comment), notice: "コメントを更新しました。" }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "コメントを削除しました。" }
      format.json { head :no_content }
    end
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
