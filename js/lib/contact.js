// api interface to cordova contacts plugin
// https://github.com/apache/cordova-plugin-contacts
// https://github.com/apache/cordova-plugin-contacts/blob/master/doc/index.md

module.exports.find = function(fields, opt, cb) {

    function onSuccess(contacts) {
        return cb(null, contacts);
    }

    function onError(contactError) {
        return cb(contactError);
    }

    navigator.contacts.find(fields, onSuccess, onError, opt);
};
