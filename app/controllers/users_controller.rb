class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :good]
  
  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @articles = @user.articles
    @ranking_good_counts = UserArticle.good_ranking
    @watched_list = @user.watches
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if login(@user.email, @user.password)
        sweetalert_success('', 'ユーザを登録しました。', timer: 2000 )
        redirect_to root_url
      end
    else
      sweetalert_error('もう一度記入してください','ユーザの登録に失敗しました。', persistent: 'OK')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
