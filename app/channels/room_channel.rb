class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    p current_user
    Message.create! user_id: current_user.id, room_id: params['room_id'], content: data['message']
  end

end
