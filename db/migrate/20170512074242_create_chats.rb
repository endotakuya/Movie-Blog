class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.integer :channel_id
      t.string :context

      t.timestamps
    end
  end
end
