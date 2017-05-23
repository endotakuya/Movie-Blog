jQuery(document).on 'turbolinks:load', ->

  _messages = $('#messages')
  scroll_to_messages _messages
  change_message_style  _messages

  App.room = App.cable.subscriptions.create channel: "RoomChannel", room_id: _messages.data('room_id'),

    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      _messages.append data['message']
      scroll_to_messages _messages
      change_message_style  _messages

    speak: (message) ->
      @perform 'speak', message: message
      

# Commnd or Ctrl + Enter で送信
$(window).keydown (e) ->
    if e.metaKey or e.ctrlKey
      if e.keyCode is 13
        if e.target.value
          App.room.speak e.target.value
        e.target.value = ''
        e.preventDefault()


# ページ表示時に最新の投稿を表示
scroll_to_messages = (messages) ->
  messages.animate({ scrollTop: messages[0].scrollHeight}, 0);


# チャットの自分と自分以外のスタイルを変更
change_message_style = (messages) ->
  user_id   = messages.attr 'class'
  $('#messages > .'+user_id+' .message').addClass('mine')
  $('#messages > .'+user_id+' .message_user_name').hide()
