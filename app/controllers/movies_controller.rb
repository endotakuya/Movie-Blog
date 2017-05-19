class MoviesController < ApplicationController

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
    else
      # キーワードがなにもないときは前のページへリダイレクト
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    access_tmdb
    @movie = Tmdb::Movie.detail(params[:id]).to_hash
    @articles = Article.where(movie_id: @movie['id'])
  end

  private
  def saerch_movies(query)
    search = Tmdb::Search.new
    search.resource('movie')
    search.query(query)
    search.fetch
  end

  def morphological_analysis(query)
    nm = Natto::MeCab.new
    query_array = []
    nm.parse(@query) do |n|
      puts "#{n.surface}\tpart-of-speech id: #{n.posid}" if !n.is_eos?
      query_array.push(n.surface) unless n.posid == 4
    end

    query_array.pop
    query_array.join(' ')
  end

end
