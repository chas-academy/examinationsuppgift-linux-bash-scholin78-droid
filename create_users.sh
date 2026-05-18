#!/bin/bash

# Uppgift 1, kontrollera om användaren är root
if test $UID = 0; then
	echo "Du är root"
else
	echo "Detta script måste köras som root."
	exit 1
fi

# Uppgift 2, skapa användare

for USERNAME in "$@"; do
	useradd -m -s /bin/bash "@USERNAME"

	HOME_DIR="/home/$USERNAME"

	mkdir -p "$HOME_DIR"/{Documents,Download,Work}

	chmod 700 "$HOME_DIR"

	echo "Välkommen @USERNAME" > "$HOME_DIR/welcome.txt"

done
