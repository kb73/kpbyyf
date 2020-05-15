#!/bin/bash

# NOTE: While this script will display the current notes and print out the different options,
# it really can only be fully appreciated when used as a bitbar plugin in the bitbar folder
# Bitbar can be downloaded at https://github.com/matryer/bitbar/releases/download/v1.9.2/BitBar-v1.9.2.zip

pass=$(tail -n 1 ./support_files/output 2> /dev/null)
# if [ "$(cat credentials 2> /dev/null)" = "" ]; then
	while [ ! "$pass" =  "pass" ]; do
		touch ./support_files/credentials
		touch ./support_files/output
		id=$(osascript -e 'Tell application "System Events" to display dialog "Enter Client ID:" default answer "" ' -e 'text returned of result')
		if [ "$id" != "" ]; then
			echo "$id">./support_files/credentials
		fi
		secret=$(osascript -e 'Tell application "System Events" to display dialog "Enter Client Secret:" default answer "" ' -e 'text returned of result')
		if [ "$secret" != "" ]; then
			echo "$secret">>./support_files/credentials
		fi
		php ./support_files/login.php
		pass=$(tail -n 1 ./support_files/output)
	done
# fi

# var for path to file that stores notes
notefile=~/.notes.txt

# Ensures notes.txt exists
touch $notefile

# Create variable which refreshes the plugin
refresh="open bitbar://refreshPlugin?name=notes.1d.sh"

# Function to delete the selected note
if [ "$1" = "delete" ]; then
    # equivalent to: sed -i '' <linenumber>d ~/bitbar_plugins/support_files/notes.txt
    sed -i '' "$2""$3" $notefile
    $refresh
fi

# Function to copy note to clipboard
## Note: for some unknown reason, it adds a new line character (\n) to the end of what is copied
if [ "$1" = "copy" ]; then
    sed -n "$2""$3" $notefile | pbcopy
fi

# Function that overrites the notes.txt file with nothing, clearing all notes
if [ "$1" = "clear" ]; then
    true > "$notefile"
    $refresh
fi

# Function to create new note
if [ "$1" = "new" ]; then
    # Opens a system dialog box and saves input to notes file
	text=$(osascript -e 'Tell application "System Events" to display dialog "New Note:" default answer "" ' -e 'text returned of result')
	if [ "$text" != "" ]; then
		echo "$text" >> $notefile
	fi
	$refresh
fi

echo "FinalNotes"
echo "---" #formatting specific to bitbar

# variable to track which line is being read
lineNum=1;

# Read through every line of the file
while read -r line; do
    echo "$line | color=#6F6F6F bash=$0 param1=copy param2=$lineNum param3=p terminal=false"
    echo "--Delete | bash=$0 param1=delete param2=$lineNum param3=d terminal=false"
    lineNum=$((lineNum+1))
done < $notefile

echo "---"
echo "New Note | bash=$0 param1=new terminal=false"

# Function which only displays the option to clear notes if at least one note exists
if [ -s $notefile ]; then
echo "Clear Notes | color=red"
echo "--I'm sure | bash=$0 param1=clear terminal=false"
fi

echo ---
# Added functionality to edit the plugin directly from the drop down menu
echo "Edit plugin | bash=$0 param1=edit terminal=false "
if [ "$1" = "edit" ]; then
    open "${0}"
fi