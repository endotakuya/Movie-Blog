class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      sweetalert_success('', 'ログインしました', timer: 2000 )
      redirect_to @user
    else
      sweetalert_error('メールアドレスまたはパスワードが間違っています','ログインに失敗しました。', persistent: 'OK')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    sweetalert_info('', 'ログアウトしました')
    redirect_to root_path
  end

  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
