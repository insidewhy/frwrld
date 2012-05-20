game = null

class Game
  constructor: (canvas) ->
    @$canvas = canvas
    @height = canvas.height()
    @width = canvas.width()
    # crafty uses a div with cr-stage, that's just how it is
    $('<div/>', id: 'cr-stage').appendTo @$canvas
    Crafty.init @width, @height

$(document).ready () ->
  game = new frwrld.Game($ '#canvas')

frwrld.Game = Game # the game class
frwrld.game = game # the single game instance

# vim:ts=2 sw=2:
