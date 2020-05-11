#!/bin/bash

# NOTE: While this script will display the current notes and print out the different options,
# it really can only be fully appreciated when used as a bitbar plugin in the bitbar folder
# Bitbar can be downloaded at https://github.com/matryer/bitbar/releases/download/v1.9.2/BitBar-v1.9.2.zip


# var for path to file that stores notes
notefile=~/.notes.txt

# Function to create new note
if [ "$1" = "new" ]; then
    # Opens a system dialog box and saves input to notes file
	text=$(osascript -e 'Tell application "System Events" to display dialog "New Note:" default answer "" ' -e 'text returned of result')
	if [ "$text" != "" ]; then
		echo "$text" >> $notefile
	fi
	$refresh
fi

# TODO add functionality for delete option (line 29)

echo "Notes"
echo "---" #formatting specific to bitbar

# Read through every line of the file
while read -r line; do
    echo "$line | color=#6F6F6F bash=$0 param1=copy param2=$lineNum param3=p terminal=false"
    echo "--Delete | bash=$0 param1=delete param2=$lineNum param3=d terminal=false"
    lineNum=$((lineNum+1))
done < $notefile

echo "---"
echo "New Note | bash=$0 param1=new terminal=false"