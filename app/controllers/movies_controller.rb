class MoviesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    # 検索キーワード（主に映画タイトル）
    @query = params[:query]
    # 中身がカラか、そもそも存在しないか
    unless @query.blank?
      access_tmdb
      @movies = saerch_movies(@query)
      # 検索キーワードが該当しなかった場合、
      # 形態素解析をして単語に分割し、再検索
      unless @movies.present?
        query = morphological_analysis(@query)
        @movies = saerch_movies(query)
      end

      @movies = search_sort(@movies)
    else    
    # キーワードがなにもないときは前のページへリダイレクト
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    movie_id = params[:id]
    access_tmdb
    # 映画の詳細情報を取得
    @movie = Tmdb::Movie.detail(movie_id).to_hash
    # この映画に関連する記事を取得
    @articles = Article.where(movie_id: movie_id)
    #ランキング数
    @ranking_stock_counts = UserArticle.stock_ranking
  end

  private
  # キーワードにマッチする映画を全取得
  def saerch_movies(query)
    search = Tmdb::Search.new
    search.resource('movie')
    search.query(query)
    search.fetch
  end

  # キーワードの形態素解析
  def morphological_analysis(query)
    nm = Natto::MeCab.new
    query_array = []
    nm.parse(@query) { |n| query_array.push(n.surface) unless n.posid == 4 }
    query_array.pop
    query_array.join(' ')
  end

  # 検索結果を公開日順に表示
  def search_sort(movies)
    movies = movies.sort_by { |hash| -hash['release_date'].to_i }
    movies
  end

end
