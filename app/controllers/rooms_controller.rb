class RoomsController < ApplicationController
  def show
    @room = params[:id]
    @chats = Chat.all.where(channel_id: params[:id])
  end
end
