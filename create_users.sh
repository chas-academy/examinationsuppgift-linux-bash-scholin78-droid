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
for user in "$@"; do
	# Kontrollera om användaren redan finns
    # if id "$user" &>/dev/null; then
	# if getent passwd "$user" > /dev/null; then
    #    echo "Användaren finns redan — hoppar över $user"
	#	continue
    # fi
	
	# Skapa användaren
	useradd -m "$user"
	
	# Kontrollerar om det gick att skapa användaren
	if [ $? -eq 0 ]; then
		echo "Användare '$user' skapad."

		# Sätta upp kataloger
		mkdir -p "/home/$user/Documents"
		mkdir -p "/home/$user/Downloads"
		mkdir -p "/home/$user/Work"	
		
		# Sätta rättigheter
     	chown -R "$user:$user" "/home/$user"
	 	chmod 700 "/home/$user/Documents"
		chmod 700 "/home/$user/Downloads"
		chmod 700 "/home/$user/Work"

	 	echo "Kataloger skapade för '$user'."

		# Skapa välkomstmeddelande
	   	echo "Välkommen $user" > "/home/$user/welcome.txt"
     else
        echo "Fel: Kunde inte skapa användare '$user'."
     fi
done

# Lägger till användarlistan sist så att alla användare kommer med
for user in "$@"; do
	awk -F: '$3 >=1000 { print $1 }' /etc/passwd >> "/home/$user/welcome.txt"
done

