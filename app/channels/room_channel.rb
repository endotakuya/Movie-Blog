class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Chat.create! user_id: 1, channel_id: params['room_id'], context: data['message']

  end

end
