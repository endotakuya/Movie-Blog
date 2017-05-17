class MoviesController < ApplicationController

  def index
    @query = params[:query]

    if @query.nil?
      @movies = []
    else
      access_tmdb
      @movies = saerch_movies(@query)
      unless @movies.present?
        query = morphological_analysis(@query)
        @movies = saerch_movies(query)
      end
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
