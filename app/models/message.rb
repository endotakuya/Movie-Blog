class Message < ApplicationRecord
  belongs_to :user
  # Validtion (room.coffeeと数字を合わせる)
  validates :content, presence: true, length: { maximum: 400 }
  
  after_create_commit { MessageBroadcastJob.perform_later self }

end
