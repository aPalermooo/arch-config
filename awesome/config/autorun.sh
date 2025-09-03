#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

# Run autostart programs
run "picom -b"
run "discord --start-minimized"


# Log Action was complete
log_path="$HOME/.config/awesome/log/autorun.log"
if [ -f "$log_path" ]
then 
	rm "$log_path"
fi

touch "$log_path"

echo "$(date '+%H:%M:%S %d-%m-%Y') -- Awesome init" >> "$log_path"
