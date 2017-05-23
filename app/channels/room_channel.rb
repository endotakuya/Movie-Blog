class RoomChannel < ApplicationCable::Channel

  def subscribed
    stream_from "#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create!( user_id: current_user.id, room_id: params['room_id'], content: data['message'] )
  rescue ActiveRecord::RecordInvalid => e
    p e.record.errors[:content]
    error_message = 'チャットメッセージは' << e.record.errors[:content]
    sweetalert_error(error_message, 送信できません, persistent: 'OK')
  end

end
