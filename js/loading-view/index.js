var debug = require('debug')('app:loading-view');

var Contact = require('../lib/contact');

var tmpl = require('./index.html');

function LoadingView() {
    if (!(this instanceof LoadingView)) {
        return new LoadingView();
    }

    var self = this;
    self.el = document.createElement('div');
    self.el.innerHTML = tmpl;
};

LoadingView.prototype.ready = function() {
    var self = this;

    var listeningElement = self.el.querySelector('.listening');
    var receivedElement = self.el.querySelector('.received');
    listeningElement.setAttribute('style', 'display:none;');
    receivedElement.setAttribute('style', 'display:block;');

    var options = {
        filter: '',
        multiple: true
    };

    var fields = ['displayName', 'name'];
    Contact.find(fields, options, function(err, contacts) {
        if (err) {
            // do something
        }

        contacts.forEach(function(contact) {
            debug(contact.displayName);
        });
    });
};

module.exports = LoadingView;
