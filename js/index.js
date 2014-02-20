require('fastclick');

// Bind any events that are required on startup. Common events are:
// 'load', 'deviceready', 'offline', and 'online'.
document.addEventListener('deviceready', device_ready, false);

function device_ready(ev) {
    var parentElement = document.getElementById('deviceready');
    var listeningElement = parentElement.querySelector('.listening');
    var receivedElement = parentElement.querySelector('.received');

    listeningElement.setAttribute('style', 'display:none;');
    receivedElement.setAttribute('style', 'display:block;');

    console.log('device ready');
}
