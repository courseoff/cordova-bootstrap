# load css
require './styles'

# Load polyfills
require 'famous-polyfills'

# import dependencies
Engine = require 'famous/core/Engine'
Modifier = require 'famous/core/Modifier'
Transform = require 'famous/core/Transform'
ImageSurface = require 'famous/surfaces/ImageSurface'

Contact = require './lib/contact.coffee'

# create the main context
mainContext = Engine.createContext()

# your app here
logo = new ImageSurface(
  size: [200, 200]
  content: 'img/famous_logo.png'
  classes: ['backfaceVisibility']
)

initialTime = Date.now()
centerSpinModifier = new Modifier(
  align: [.5, .5]
  origin: [.5, .5]
  transform: ->
    return Transform.rotateY .002 * (Date.now() - initialTime)
)

options =
  filter: ""
  multiple: true

Contact.find ["displayName", "name"], options, (err, contacts) ->
  contacts.forEach (contact) ->
    console.log contact.displayName
    return
  return

mainContext.add(centerSpinModifier).add logo
