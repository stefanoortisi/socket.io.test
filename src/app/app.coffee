class App

	constructor: ( ) ->
		

		@incomingChatMessages = $ '#incomingChatMessages'
		@outgoingChatMessage = $ '#outgoingChatMessage'

		@outgoingChatMessage.keypress @on_submit

		@iosocket = io.connect 'http://localhost:8888'

		@iosocket.on 'message', @on_message
		@iosocket.on 'disconnect', @on_disconnect

	on_disconnect: ( ) =>
		@incomingChatMessages.append('<li>Disconnected</li>')

	on_message: ( message ) =>
		@incomingChatMessages.append($('<li></li>').text(message.message))

	on_submit: ( event ) =>
		if event.which is 13
			event.preventDefault()
			@iosocket.emit 'send', @outgoingChatMessage.val()
			@outgoingChatMessage.val ''



$ -> window.app = new App