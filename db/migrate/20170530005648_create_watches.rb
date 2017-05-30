class CreateWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :watches do |t|
      t.references :user, foreign_key: true
      t.integer :movie_id
      t.string :movie_title
      t.string :movie_poster_path

      t.timestamps
    end
  end
end
