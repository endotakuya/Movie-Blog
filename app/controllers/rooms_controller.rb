class RoomsController < ApplicationController

  layout 'room'

  def show
    # RoomID を 映画ID と紐付け
    @room_id = params[:id]
    current_user.join_room(@room_id)

    # 現在のRoom内メッセージを取得
    @messages = Message.all.where(room_id: @room_id)

    # 過去に入ったことのあるチャット一覧
    room_ids = current_user.user_rooms.pluck(:room_id)

    # 過去に入ったことのあるチャットと映画を紐付け
    @join_rooms = {}
    @join_images = {}
    room_ids.each do |room_id|
      movie = join_movie(room_id)
      @join_rooms[room_id] = movie['title']
      @join_images[room_id] = movie['poster_path']
    end

    # メッセージ切り分け用
    @user_id = current_user.id

  end

  private
  def join_movie(room_id)
    access_tmdb
    movie = Tmdb::Movie.detail(room_id)
    movie
  end
  
end
