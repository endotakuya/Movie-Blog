class RoomsController < ApplicationController
  def show
    @room_id = params[:id]
    @messages = Message.all.where(room_id: @room_id)
  end
end
