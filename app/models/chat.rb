class Chat < ApplicationRecord
  belongs_to :user

  after_create_commit { ChatBroadcastJob.perform_later self }
end
