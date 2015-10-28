class Dashing.Halt extends Dashing.ClickableWidget

#  powerOff: ->
#    $.get 'system/halt'

  ready: ->

  haltSystem: ->
    $.get 'functions/halt',
      (data) =>
        if data
          alert data

  rebootSystem: ->
    $.get 'functions/reboot',
      (data) =>
        if data
          alert data


  onClick: (event) ->
    if @get('action') == 'halt'
      @haltSystem()
    else if @get('action') == 'reboot'
      @rebootSystem()
