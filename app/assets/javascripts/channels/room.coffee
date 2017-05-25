jQuery(document).on 'turbolinks:load', ->

  _messages = $('#messages')
  scroll_to_messages _messages
  change_message_style  _messages
  valid = yes

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
        if e.target.value and valid
          App.room.speak e.target.value
          e.target.value = ''
          e.preventDefault()


  # TextArea Validation
  $('#write').on 'keydown keyup keypress change', ->
    # Validtion (message.rbと数字を合わせる)
    maxValueLength      = 400
    thisValueLength     = $(this).val().length
    distanceValueLength = maxValueLength - thisValueLength

    $('.text_length').text(distanceValueLength)

    if maxValueLength < thisValueLength
      valid = no
      $(this).css 'background-color':'rgba(255,192,203, 0.1)', 'border':'1px solid #ffc0cb'
    else
      valid = yes
      $(this).css 'background-color':'transparent', 'border-top': '1px solid rgba(0, 0, 0, .20)','border-bottom:':'1px solid rgba(0, 0, 0, .20)', 'border-left':'none', 'border-right':'none'


  # 送信ボタンからPost
  $('.chat_textarea .post_btn').click (e) ->
    _textarea = $('#write')
    App.room.speak _textarea.val()
    _textarea.val('')
    $('.text_length').text(400)
    e.preventDefault() 


# ページ表示時に最新の投稿を表示
scroll_to_messages = (messages) ->
  messages.animate({ scrollTop: messages[0].scrollHeight}, 0);


# チャットの自分と自分以外のスタイルを変更
change_message_style = (messages) ->
  user_id   = messages.attr 'class'
  $('#messages > .'+user_id+' .message').addClass('mine')
  $('#messages > .'+user_id+' .message_user_name').hide()
