
on run argv

  launch "iTerm"

  tell application "iTerm"
   activate

   -- my project workspace
   set myterm to (make new terminal)
   tell myterm
    launch session "socket"

    set number of columns to 160
    set number of rows to 40


    -- start mongod
    tell the current session to write text "cd " & item 1 of argv
    tell the current session to write text "mongod"

    -- watch polvo
    tell i term application "System Events" to keystroke "D" using command down

    tell the current session to write text "cd " & item 1 of argv
    tell the current session to write text "cd " & item 1 of argv
    tell the current session to write text "make polvo"

    -- watch server
    tell i term application "System Events" to keystroke "[" using command down
    tell i term application "System Events" to keystroke "d" using command down

    tell the current session to write text "cd " & item 1 of argv
    tell the current session to write text "cd " & item 1 of argv
    tell the current session to write text "make server"

    tell i term application "System Events" to keystroke "]" using command down
    tell i term application "System Events" to keystroke "d" using command down

    tell the current session to write text "cd " & item 1 of argv
    tell the current session to write text "cd " & item 1 of argv

   end tell



  end tell
end run