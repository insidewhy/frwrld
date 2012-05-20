window.frwrld =
  get: {}

if window.location.search
  splitter = /[?&]([^=]+)=([^&]+)/g
  while match = splitter.exec window.location.search
    frwrld.get[match[1]] = match[2]

$(document).ready () ->
  if window.location.pathname is '/register'
    frwrld.registerEmailCredentials()

# vim:ts=2 sw=2:
