class RankingsController < ApplicationController
  def stock
    @ranking_stock_counts = UserArticle.stock_ranking
    @articles = Article.find(@ranking_stock_counts.keys)
  end
end
