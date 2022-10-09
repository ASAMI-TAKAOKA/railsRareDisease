# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # # GET /users/sign_in
  def new
    super
  end

  # # POST /users/sign_in
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user_path
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが無効です。' # 本当は正しくない
      render 'new'
    end
  end

  # # DELETE /users/sign_out
  def destroy
    log_out
    redirect_to new_user_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
