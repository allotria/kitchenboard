class Dashing.Halt extends Dashing.ClickableWidget

#  powerOff: ->
#    $.get 'system/halt'

  ready: ->

  onClick: (event) ->
    $.get 'functions/halt',
      (data) =>
        if data
          alert data

