class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :stock]
  
  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @articles = @user.articles
    @ranking_stock_counts = UserArticle.stock_ranking
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def stock
    @articles = current_user.stocks
    @ranking_stock_counts = UserArticle.stock_ranking
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
