class RankingsController < ApplicationController
  def good
    @ranking_good_counts = UserArticle.good_ranking
    @articles = Article.find(@ranking_good_counts.keys)
  end

  def pv
    @ranking_pv_counts = Impression.group(:impressionable_id).order('count_all desc').limit(10).count
    @articles = Article.find(@ranking_pv_counts.keys)
  end

end
