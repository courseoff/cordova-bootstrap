require("fastclick")
debug = require("debug")("app")

# require the loading view so we can instantiate it
LoadingView = require "./loading-view"

# make a view
view = LoadingView()

# add it to the page
container = document.querySelector('.app')
container.appendChild(view.el)

device_ready = (ev)->
  debug "device ready"
  view.ready()
  return

# Bind any events that are required on startup. Common events are:
# 'load', 'deviceready', 'offline', and 'online'.
document.addEventListener 'deviceready', device_ready, false
