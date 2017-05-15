class CreateRoomUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :room_users do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps

      t.index [:user_id, :room_id], unique: true
    end
  end
end
