class AddPosterUrlToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :poster_url, :string
  end
end
