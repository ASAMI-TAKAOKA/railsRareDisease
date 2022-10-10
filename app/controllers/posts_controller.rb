class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
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
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "記事を更新しました。" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "記事を削除しました。" }
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
