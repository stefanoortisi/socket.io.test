app = require('http').createServer (req, res) -> res.end()
io = require('socket.io').listen(app.listen(8888))

io.sockets.on 'connection', (socket) ->
	socket.emit 'message', message: 'welcome to the chat'

	socket.on 'send', (data) ->
		io.sockets.emit 'message', message : data

