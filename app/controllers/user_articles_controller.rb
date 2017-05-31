class UserArticlesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    current_user.good(@article)
    @ranking_good_counts = UserArticle.good_ranking
  end

  def destroy
    @article = Article.find(params[:article_id])
    current_user.ungood(@article)
    @ranking_good_counts = UserArticle.good_ranking
  end

end
