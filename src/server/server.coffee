conf  		= require './conf.json'
app  		= require('http').createServer (req, res) -> res.end()
mongoose  	= require 'mongoose'
Message 	= require './model/message'
io  		= require( 'socket.io' ).listen( app.listen( conf.port ) )


# DB Connection
mongoose.connect conf.mongodb
db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')
db.once 'open', ->
	console.log 'db connection opened'


# Socket Connection
console.log "socket started at #{conf.port}"

io.set 'log level', 1

io.sockets.on 'connection', (socket) ->

	Message.find (err, data) -> socket.emit 'first_data', data

	socket.on 'send', (data) ->
		message = new Message name : data.name
		console.log 'received new message with name', message.name

		message.save on_message_saved


	socket.on 'delete_all', (data) ->
		Message.remove {}, on_messages_removed


		

on_messages_removed = ( err, data ) ->
	if err then return console.error err
	io.sockets.emit 'message_removed', data


on_message_saved = ( err, new_message ) ->
	if err then return console.error err
	io.sockets.emit 'message', [new_message]