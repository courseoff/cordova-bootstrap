# api interface to cordova contacts plugin
# https://github.com/apache/cordova-plugin-contacts
# https://github.com/apache/cordova-plugin-contacts/blob/master/doc/index.md

module.exports.find = (fields, opt, cb) ->
  onSuccess = (contacts) ->
    cb null, contacts
  onError = (contactError) ->
    cb contactError
  navigator.contacts.find fields, onSuccess, onError, opt if navigator.contacts
  return
