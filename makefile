server:
	supervisor src/server/server.coffee

polvo:
	polvo -ws

iterm:
	osascript ./start_iterm.scpt $(PWD)