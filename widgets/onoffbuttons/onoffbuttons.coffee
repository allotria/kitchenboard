class Dashing.Onoffbuttons extends Dashing.ClickableWidget
  constructor: ->
    super


  turnOn: ->
    $.post '/tellstick/turnon',
    deviceId: @get('device')

  turnOff: ->
    $.post '/tellstick/turnoff',
    deviceId: @get('device')

  ready: ->

  onData: (data) ->

  onClick: (event) ->
    if event.target.id == "turn-on"
      @turnOn()
    else if event.target.id == "turn-off"
      @turnOff()

