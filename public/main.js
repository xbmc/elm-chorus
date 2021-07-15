//@ts-check
import { Elm } from '../src/Main.elm';

// document.addEventListener("DOMContentLoaded", function () {
//   // Initial data passed to Elm (should match `Flags` defined in `Shared.elm`)
//   // https://guide.elm-lang.org/interop/flags.html

  
// });

var storedData = localStorage.getItem('kodiLocalPlaylists');

  var flags = {
    innerWidth: window.innerWidth,
    innerHeight: window.innerHeight,
    localPlaylists: storedData ? storedData : null,
  };

  // Start our Elm application
  var app = Elm.Main.init({
    node: document.getElementById("main"),
    flags: flags,
  });

  var ws = new WebSocket("ws://localhost:9090");

  ws.onopen = () => {
    app.ports.connection.send("Connected");

    // When a command goes to the `sendMessage` port, we pass the message
    // along to the WebSocket.
    app.ports.sendActions.subscribe(function (action) {
      var actionListLength = action.length;
      for (var i = 0; i < actionListLength; i++) {
        ws.send(action[i]);
        //console.log(action[i]);
      }
    });

    // When a message comes into our WebSocket, we pass the message along
    // to the `messageReceiver` port.
    ws.addEventListener("message", function (event) {
      app.ports.responseReceiver.send(event.data);
      console.log(event.data);
    });
    // Ports go here
    // https://guide.elm-lang.org/interop/ports.html
  };
  ws.onerror=function(event){
    app.ports.connection.send("Disconnected");
  }
  window.onbeforeunload = function () {
    app.ports.connection.send("Disconnected");
    ws.close();
  };

  // Listen for commands from the `setStorage` port.
  // Turn the data to a string and put it in localStorage.
  app.ports.setStorage.subscribe(function (playlists) {
      localStorage.setItem('kodiLocalPlaylists', playlists);
  });
