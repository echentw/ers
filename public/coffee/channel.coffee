require(['jquery', 'client'], ($, Client) ->

  $(document).ready( ->

    channelID = $('#channelID').text()
    username = $('#username').text()

    client = new Client(channelID, username)

    $('#start').click( ->
      client.start()
    )

    $(document).keypress((e) ->
      if e.which == 13
        client.playCard()
      else if e.which == 32
        client.slap()
    )
  )
)
