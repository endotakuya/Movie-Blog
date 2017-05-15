class AddMovieIdToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :movie_id, :string
  end
end
