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
    end
    
  end

  def show
    access_tmdb
    @movie = Tmdb::Movie.detail(params[:id])
    p @movie
    @articles = Article.where(movie_id: @movie['id'])
  end
  
end
