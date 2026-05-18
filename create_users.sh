#!/bin/bash

# Uppgift 1, kontrollera om användaren är root
if test $UID = 0; then
	echo "Du är root"
else
	echo "Detta script måste köras som root."
	exit 1
fi

# Uppgift 2, skapa användare
# Testar om argument med användare har skickats
if [ $# -eq 0 ]; then
    echo "Användning: $0 användarnamn1 användarnamn2 ..."
    exit 1
fi

# Loopar igenom varje användare / argument
for username in "$@"; do
	# Skapa användaren
	useradd -m "$username"

	# Kontrollerar om det gick att skapa användaren
	if [ $? -eq 0 ]; then
		echo "Användare '$username' skapad."

		# Sätta upp kataloger
        mkdir -p "/home/$username/Documents"
        mkdir -p "/home/$username/Download"
       	 mkdir -p "/home/$username/Work"	
		
		# Sätta rättigheter
        chown -R "$username:$username" "/home/$username"
		chmod 700 "/home/$username"

		echo "Kataloger skapade för '$username'."
    else
        echo "Fel: Kunde inte skapa användare '$username'."
    fi
done
