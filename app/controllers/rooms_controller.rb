class RoomsController < ApplicationController
  def show
    @chats = Chat.all
  end
end
