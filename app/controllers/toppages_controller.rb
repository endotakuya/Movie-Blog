class ToppagesController < ApplicationController
  def index
    @articles = Article.limit(4).order("id DESC")
  end
end
