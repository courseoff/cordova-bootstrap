require('fastclick');

// require the loading view so we can instantiate it
var LoadingView = require('./loading-view');

// make a view
var view = LoadingView();

// add it to the page
var container = document.querySelector('.app');
container.appendChild(view.el);

// Bind any events that are required on startup. Common events are:
// 'load', 'deviceready', 'offline', and 'online'.
document.addEventListener('deviceready', device_ready, false);

function device_ready(ev) {
    console.log('device ready');
    view.ready();
}
