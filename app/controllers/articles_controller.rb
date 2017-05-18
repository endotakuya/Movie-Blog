class ArticlesController < ApplicationController
  before_action :require_user_logged_in
  impressionist actions: [:show]

  layout 'article'
  include ArticlesHelper

  def show
    # １記事のデータを取得
    @article = Article.find(params[:id])

    # 映画情報取得
    access_tmdb
    @movie = Tmdb::Movie.detail(@article[:movie_id])

    # ストック数をカウント
    @ranking_stock_counts = UserArticle.stock_ranking

    gon.point_list = [ @article.point_1, @article.point_2, @article.point_3, @article.point_4, @article.point_5]
    
  end

  def new
    @article = Article.new({ :movie_title => params['title'], :movie_id => params['id'], :poster_url => params['poster_path'] })
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      sweetalert_success('', '記事を投稿しました', timer: 2000 )
      redirect_to movie_path(@article.movie_id)
    else
      sweetalert_error('記入漏れがないか、確認してください','投稿できませんでした', persistent: 'OK')
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      sweetalert_success('', '更新しました', timer: 2000 )
      redirect_to @article
    else
      sweetalert_error('記入漏れがないか、確認してください','更新できませんでした', persistent: 'OK')
      render :edit
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
