fs = require("fs")
http = require("http")
socketio = require("socket.io")

server = http.createServer((req, res) ->
	res.writeHead 200, "Content-type": "text/html"
	res.end fs.readFileSync __dirname + "/public/index.html"
).listen(8080)

socketio.listen(server).on "connection", (socket) -> 
	socket.on "message", on_message
		

on_message = (msg) ->
	socket.broadcast.emit "message", msg