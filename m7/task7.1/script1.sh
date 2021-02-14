#!/bin/bash

usage()
{
  echo "Usage: script1
  [ --all displays the IP addresses and symbolic names of all hosts in the current subnet]
  [ --target displays a list of open system TCP port]"
}

show_tcp_ports()
{
  netstat -tln
}

show_hosts()
{
  echo "Hosts in current network:"
  arp -a | cut -d" " -f1-2
}

parsed=$(getopt -qau -o "" -l all,target -- "$@" )

if [[ $? -ne 0 || "$parsed" = " --" ]]; then
	usage
	exit 2
fi

while [[ $# -gt 0 ]]; do
	case "$1" in
		--all)
			shift
		       	show_hosts
			echo
			;;

	       	--target)
			shift
			show_tcp_ports
			echo
			;;

		*)
			break
			;;
	esac
done

