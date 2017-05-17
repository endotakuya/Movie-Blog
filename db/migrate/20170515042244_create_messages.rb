class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.integer :room_id

      t.timestamps
    end
  end
end
