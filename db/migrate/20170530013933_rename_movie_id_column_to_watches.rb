class RenameMovieIdColumnToWatches < ActiveRecord::Migration[5.1]
  def change
    change_column :watches, :movie_id, :string
  end
end
