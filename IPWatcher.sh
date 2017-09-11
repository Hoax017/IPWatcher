clear
echo "IP watcher v1 by AymericDev.fr"
echo "This tool use nmcli and paplay command"

ip=$(curl -s --connect-timeout 5 ipinfo.io/ip)
if [[ -z "${ip}" ]]
then
	echo "Empty IP for check"
	echo "Write 'nmcli radio wifi on' for enable wifi"
	paplay end.wav
	exit
fi

echo "Your IP : ${ip}"
echo "Watching "

while [[ 1 ]]
do
	echo -en "."
	iptmp=$(curl -s --connect-timeout 5 ipinfo.io/ip)
	while [[ -z "${iptmp}" ]]; do
	 	iptmp=$(curl -s --connect-timeout 5 ipinfo.io/ip)
	done
	if [[ "${ip}" != "${iptmp}" ]] && [[ -n "${iptmp}" ]]
	then
		echo -en "\nIP changed '${iptmp}'\n"
		echo -en "Disabling wifi \n"
		nmcli radio wifi off
		echo -en "Write 'nmcli radio wifi on' for enable wifi\n"
		paplay end.wav
		exit
	fi
	if [[ $COUNTER = 5 ]]
	then
		paplay end.wav
		exit
	fi
done
