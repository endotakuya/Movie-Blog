class UserArticlesController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    current_user.good(article)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    article = Article.find(params[:article_id])
    current_user.ungood(article)
    redirect_back(fallback_location: root_path)
  end

end
