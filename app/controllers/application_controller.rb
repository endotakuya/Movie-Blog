class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  include SessionsHelper

  # 404エラー
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: "errors/error_404", status: 404, layout: 'application'
  end

  # 500エラー
  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: "errors/error_500", status: 500, layout: 'application'
  end

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

  private
  # ログイン判定
  # していなければ、ログインページへリダイレクト
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  # TMDB API へのアクセス
  def access_tmdb
    Tmdb::Api.key(ENV['MOVIEDB_API_KEY'])
    Tmdb::Api.language("ja")
  end

end
