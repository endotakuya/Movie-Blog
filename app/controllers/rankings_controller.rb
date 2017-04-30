class RankingsController < ApplicationController
  def stock
    @ranking_stock_counts = UserArticle.stock_ranking
    @articles = Article.find(@ranking_stock_counts.keys)
  end

  def pv
    @ranking_pv_counts = Impression.group(:impressionable_id).order('count_all desc').limit(10).count
    @articles = Article.find(@ranking_pv_counts.keys)
  end

end
