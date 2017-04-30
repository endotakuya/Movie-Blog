class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :movie_title
      t.string :article_title
      t.string :director
      t.string :performer
      t.string :content
      t.string :release_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end