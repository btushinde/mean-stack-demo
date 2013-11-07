window.bootstrap = ->
  angular.bootstrap document, ["mean"]

window.init = ->
  window.bootstrap()

angular.element(document).ready ->

  #Fixing facebook bug with redirect
  window.location.hash = ""  if window.location.hash is "#_=_"

  #Then init the app
  window.init()
