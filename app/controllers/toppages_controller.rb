class ToppagesController < ApplicationController
  def index
    @articles = Article.limit(4).order("id").reverse_order
    @ranking_good_counts = UserArticle.good_ranking
  end
end
