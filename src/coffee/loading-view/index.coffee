LoadingView = ->
  return new LoadingView() unless this instanceof LoadingView
  self = this
  self.el = document.createElement("div")
  self.el.innerHTML = tmpl
  return

debug = require("debug")("app:loading-view")
Contact = require("../lib/contact.coffee")
tmpl = require("./index.html")

LoadingView::ready = ->
  self = this
  listeningElement = self.el.querySelector('.listening')
  receivedElement = self.el.querySelector('.received')
  listeningElement.setAttribute "style", "display:none"
  receivedElement.setAttribute "style", "display:block"
  options =
    filter: ""
    multiple: true

  fields = [
    "displayName",
    "name"
  ]

  Contact.find fields, options, (err, contacts) ->
    # if (err)
      # do something
    contacts.forEach (contact) ->
      debug contact.displayName
      return
    return
  return

module.exports = LoadingView
