// Initial data passed to Elm (should match `Flags` defined in `Shared.elm`)
// https://guide.elm-lang.org/interop/flags.html
var flags = null

// Start our Elm application
var app = Elm.Main.init({ node: document.querySelector("main"), flags: flags })

var socket = new WebSocket("ws://localhost:9090");

// When a command goes to the `sendMessage` port, we pass the message
// along to the WebSocket.
app.ports.sendActions.subscribe(function (action) {
	var actionListLength = action.length;
	for (var i = 0; i < actionListLength; i++) {
    	socket.send(action[i]);
    	console.log(action[i]);
	}
});

// When a message comes into our WebSocket, we pass the message along
// to the `messageReceiver` port.
socket.addEventListener("message", function (event) {
	app.ports.responseReceiver.send(event.data);
});
// Ports go here
// https://guide.elm-lang.org/interop/ports.html