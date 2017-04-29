class UserArticlesController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    current_user.stock(article)
    flash[:success] = '記事をストックしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    article = Article.find(params[:article_id])
    current_user.unstock(article)
    flash[:success] = '記事のストックを解除しました'
    redirect_back(fallback_location: root_path)
  end

end
