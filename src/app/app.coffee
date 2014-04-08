class App

	constructor: ( ) ->
		

		@incomingChatMessages 	= $ '#incomingChatMessages'
		@outgoingChatMessage 	= $ '#outgoingChatMessage'
		@delete_btn  			= $ '#delete_messages'

		@outgoingChatMessage.keypress @on_submit
		@delete_btn.on 'click', @delete_messages

		@iosocket = io.connect 'http://stefano.local:8888'

		@iosocket.once 'first_data', @on_first_data
		@iosocket.on 'message', @on_message
		@iosocket.on 'disconnect', @on_disconnect
		@iosocket.on 'message_removed', @on_messages_removed

		

	on_first_data: ( data ) =>
		@on_message data


	on_disconnect: ( ) =>
		@incomingChatMessages.append('<li>Disconnected</li>')

	on_message: ( data ) =>
		for item in data
			@incomingChatMessages.append($('<li></li>').text(item.name))

	on_submit: ( event ) =>
		if event.which is 13
			event.preventDefault()
			@iosocket.emit 'send', name : @outgoingChatMessage.val()
			@outgoingChatMessage.val ''


	on_messages_removed: ( data ) =>
		console.log data
		@incomingChatMessages.html ''


	delete_messages: ( ) =>
		@iosocket.emit 'delete_all', {}

$ -> window.app = new App