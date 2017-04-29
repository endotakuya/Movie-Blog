class MoviesController < ApplicationController

  def index
    @query = params[:query]
    
    if @query.nil?
      @movies = []
    else
      access_tmdb
      search = Tmdb::Search.new
      search.resource('movie')
      search.query(@query)
      @movies = search.fetch 
      p @movies # ログ用
    end
    
  end

  def show
    access_tmdb
    @movie = Tmdb::Movie.detail(params[:id])
  end
  
  private
  def access_tmdb
    Tmdb::Api.key(ENV['MOVIEDB_API_KEY'])
    Tmdb::Api.language("ja")
  end
  
end
