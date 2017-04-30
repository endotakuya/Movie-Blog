class ToppagesController < ApplicationController
  def index
    @articles = Article.limit(4).order("id DESC")
    @ranking_stock_counts = UserArticle.stock_ranking
  end
end
