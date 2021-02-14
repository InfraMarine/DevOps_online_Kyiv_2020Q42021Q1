#!/bin/bash

usage()
{
	echo "Options:
  -i show how many requests from each ip
  -I show ip with most requests
  -p show the most requested page
  -e show non-existent pages were clients referred to
  -t time site got the most requests
  -b what search bots have accessed the site
"
}

topIP()
{
  awk '{print $1}' example_log.log | sort | uniq -c | sort -r | head -1
}

topPage()
{
  awk '{print $7}' example_log.log | grep .html | uniq -c | sort -r | head -1	
}

ipStat()
{
  awk '{print $1}' example_log.log | sort | uniq -c | sort
}

pages404()
{
  awk '{print $7" "$9}' example_log.log | grep 404 | grep .html| awk '{ print $1}' | uniq
}

timePeak ()
{
  grep "25/Apr" example_log.log | cut -d[ -f2 | cut -d] -f1 | awk -F: '{print $2":00"}' | sort -n | uniq -c | sort -rn | head -1
}

show_bots ()
{
  cat example_log.log | cut -f12- -d" " | grep bot | sort | uniq -c | sort -n
}

parsed=$(getopt -qau -o i,I,p,e,t,b  -- "$@" )

if [[ $? -ne 0 || "$parsed" = " --" ]]; then
	usage
	exit 2
fi

case "$1" in
	-i)
        	ipStat
		;;
	-I)
		topIP
		;;
	-p)
		topPage
		;;
	-e)
		pages404
		;;
	-t)
		timePeak
		;;
	-b)
		show_bots
		;;

	*)
		;;
esac
