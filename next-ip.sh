#!/bin/bash
find_next_user_ip()
{
	ip=$1
	nextip=$(awk -F\. '{ print $1"."$2"."$3"."$4+1 }' <<< $ip )
	echo "Next available IP for User is $nextip "
}

ipf=`(find /etc/openvpn/ccd/ -type f -not -name '*-[0-9]*' | xargs cat | grep  "10.9.1.[0-9]" | awk '{ print $2 }' | sort  -n -t . -k1,1 -k2,2 -k 3,3 -k4,4 | tail -1)`
find_next_user_ip $ipf
