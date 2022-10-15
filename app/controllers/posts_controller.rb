class PostsController < ApplicationController
  before_action :set_post, only: %i[ index show edit ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)

    # ここから下、一旦保留
    # @post = Post.find(params[:id])    
    # @comment = @post.comments.build #buildの利用
    # @comment = Comment.new #newの利用でも良いが、外部参照キーを自動でセットしてくれないので少し不便。

    # postsテーブルとcommentsテーブルはアソシエーションが組まれているため、
    # @post.commentsとすることで、@postについて投稿された全てのコメントを取得することができる。
    # ビューではどのユーザーのコメントかを明らかにするために、アソシエーションを使ってユーザーのレコードを取得する処理をする。
    # includesメソッドはN+1問題解消のために使用
    # @comments = @post.comments.includes(:user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "新規記事を投稿しました。" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: "記事を編集しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render 'edit'
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "削除しました。" }
      format.json { head :no_content }
    end
  end

  private
    # アクション間で共通の設定や制約を共有するには、コールバックを使用する
    # コールバック:バリデーションの実行やDBへの保存などのタイミングで処理を行うための機能
    # あるタイミングで必ず実行する必要がある処理をコールバックに指定することで、モデルの一貫性を保つことができる
    def set_post
      @post = Post.find(params[:id])
    end

    # 信頼できるパラメータのリストのみ通過させる。
    def post_params
      params.require(:post).permit(:titile, :body).merge(user_id: current_user.id)
    end
end
