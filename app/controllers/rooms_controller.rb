class RoomsController < ApplicationController
  def show
    @room_id = params[:id]
    current_user.join_room(@room_id)
    current_user.user_rooms.pluck(:room_id)
    @messages = Message.all.where(room_id: @room_id)
  end
end
