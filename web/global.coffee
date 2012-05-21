window.frwrld =
  get: {}

class frwrld.Tooltip
  constructor: (to, content, side = 'right') ->
    @$ = $('<div/>', { class: 'tooltip', html: content }).appendTo($ 'body')
    offset = to.offset()

    switch side
      when 'right'
        offset.left += to.outerWidth() + parseInt(@$.css 'margin-left')
      when 'bottom'
        offset.top -= to.outerHeight() + parseInt(@$.css 'margin-top')

    @$.offset offset

  close: ->
    @$.fadeOut()

if window.location.search
  splitter = /[?&]([^=]+)=([^&]+)/g
  while match = splitter.exec window.location.search
    frwrld.get[match[1]] = match[2]

$(document).ready () ->
  if window.location.pathname is '/register'
    frwrld.registerEmailCredentials()

# vim:ts=2 sw=2:
