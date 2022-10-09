module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

    # 現在ログインしているユーザーを返す (ユーザーがログイン中の場合のみ)
  def current_user
    if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  def require_login
    redirect_to new_user_session_path if !logged_in?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end