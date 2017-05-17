class UserArticlesController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    current_user.stock(article)
    sweetalert_success('', '記事をストックしました', timer: 1000 )
    redirect_back(fallback_location: root_path)
  end

  def destroy
    article = Article.find(params[:article_id])
    current_user.unstock(article)
    sweetalert_info('', '記事のストックを解除しました', timer: 1000 )
    redirect_back(fallback_location: root_path)
  end

end
