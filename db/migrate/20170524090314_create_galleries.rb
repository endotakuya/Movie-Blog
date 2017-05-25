class CreateGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :galleries do |t|
      t.integer :movie_id
      t.string :image

      t.timestamps
    end
  end
end
