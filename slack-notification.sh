#!/bin/bash

#Calling the alert channel
slack_notify()
{
        url=https://hooks.slack.com/services/T012PD7UB/B0115126/123453232 (dummy)
        curl -X POST -H 'Content-type: application/json' --data '{ "text": "'"$msg"'" }' $url
	      json=`cat /var/local/adm/payload` && curl -s -d "payload=$json" "$url"
}


for line in `cat /var/local/adm/queuename`
do
  qname=$(echo "$line" | cut -d',' -f1);
  threshold1=$(echo "$line" | cut -d',' -f2);
  threshold2=$(/usr/sbin/rabbitmqctl list_queues | grep $qname |grep -v pid | awk '{print $2}');
  if [ $threshold2 -gt $threshold1 ]; then
          msg="Queue $qname has $threshold2 messages crossing the threshold of $threshold1"
          slack_notify
  fi
done


cat /var/local/adm/payload
cat: cat: No such file or directory
{
    "attachments": [
        {
            "fallback": "RabbitMQ-Alert",
            "callback_id": "wopr_game",
            "color": "#3AA3E3",
            "attachment_type": "default",
            "actions": [
                {
                    "name": "game",
                    "text": "RabbitMQ-Alert",
                    "style": "danger",
                    "type": "button",
                    "value": "war",
                    "confirm": {
                        "title": "Are you sure?",
                        "text": "Thanks for acknowledging"
                    }
                }
            ]
        }
    ]
}
