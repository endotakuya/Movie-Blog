class ArticlesController < ApplicationController
  before_action :require_user_logged_in, except: :show
  impressionist actions: [:show]

  layout 'article'

  def index
    @articles = Article.all.order("id DESC").page(params[:page]).per(30)
    @ranking_good_counts = UserArticle.good_ranking
  end

  def show
    # １記事のデータを取得
    movie_id = params[:id]
    @article = Article.find(movie_id)
    # 映画情報取得
    access_tmdb
    @movie = Tmdb::Movie.detail(@article[:movie_id])
    # いいね数をカウント
    @ranking_good_counts = UserArticle.good_ranking
    # JSで値を使えるように
    gon.point_list = [ @article.point_1, @article.point_2, @article.point_3, @article.point_4, @article.point_5]
  end

  def new
    @article = Article.new({ :movie_title => params['title'], :movie_id => params['id'], :poster_url => params['poster_path'] })
    @galleries = current_user.galleries.where(movie_id: params['id'])
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      sweetalert_success('', '記事を投稿しました', timer: 2000 )
      redirect_to movie_url(@article.movie_id)
    else
      errors = {:article_title => '記事名', :director => '監督名', :performer => '出演者', :content => '本文', :release_date => '公開日' }
      error_message = []
      @article.errors.messages.each_key {|key| error_message.push(errors[key]) }
      result_error = error_message.join('、') << 'を記入してください'

      sweetalert_error(result_error , '投稿できませんでした', persistent: 'OK')
      @galleries = current_user.galleries.where(movie_id: params[:article][:movie_id])
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    # JSで値を使えるように
    gon.point_list = [ @article.point_1, @article.point_2, @article.point_3, @article.point_4, @article.point_5]

    @galleries = current_user.galleries.where(movie_id: @article.movie_id)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      sweetalert_success('', '更新しました', timer: 2000 )
      redirect_to @article
    else
      sweetalert_error('記入漏れがないか、確認してください', '更新できませんでした', persistent: 'OK')
      render :edit
      clear_flash
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    sweetalert_info('', '投稿を削除しました', timer: 2000 )
    redirect_to root_url
  end

  private
  def article_params
    params.require(:article).permit(:user_id, :movie_title, :article_title, :director, :performer, :content, :release_date, :movie_id, :poster_url, :point_1, :point_2, :point_3, :point_4, :point_5  )
  end

end
