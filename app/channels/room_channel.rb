class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "hoge"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Chat.create! user_id: 1, channel_id: 1, context: data['content']

  end

end
