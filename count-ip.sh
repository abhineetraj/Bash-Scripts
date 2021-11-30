#This script counts the ip in the access log files for nginx for the last n hours

#!/bin/bash
:> /tmp/logs
:> /tmp/ips
zero=0

#define the global function to check the input
check_number()
{
re='^[0-9]+$'
if ! [[ $hrs =~ $re ]] ; then
   echo "Duration is not an integer" >&2; exit 1
elif [[ $hrs -gt 4 ]];
then
   echo "Duration is more than 4 hours, please enter less than 5 hours" && exit 1
fi
}


printf "Enter the duration to find the count of unique IP's from nginx logs? (1/2/3/4)\n"
read hrs
check_number

#grep the nginx logs
for (( i=$zero; i<=$hrs; i++ ))
do
    grep `date -d now-${i}hours  +%d/%b/%Y:%H` /var/log/nginx/access.log >> /tmp/abcd_updated_logs
done

#Calculate the ip's
awk '{print $1}' /tmp/logs > /tmp/ips
printf "Logs are stored @ /tmp/logs\n" && sleep 2
printf "Printing the count of IP's for the last $hrs hours \n"
source /var/local/adm/progress.sh && progressbar 5
sort /tmp/ips | uniq -c | sort -n -r -k1,1 | head -40
