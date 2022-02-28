#This sets the temporary root creds through SSM agent to any other intended user on an on-prem or EC2 instance.

#!/bin/bash

line_num=$(grep -n "default" /root/.aws/credentials | cut -d ":" -f1)
last_line=$(($line_num+3))
head -$last_line /root/.aws/credentials | tail -3 > temp_credentials

#Getting the new credentials
access_key_id=$(cat temp_credentials | grep "aws_access_key_id" | awk '{print $3}')
secret_access_key=$(cat temp_credentials | grep "aws_secret_access_key" | awk '{print $3}')
session_token=$(cat temp_credentials | grep "aws_session_token" | awk '{print $3}')

#Setting the user level aws credentials for <username>
su - <username> <<EOF
    aws configure set aws_access_key_id $access_key_id --profile <profile-name>
    aws configure set aws_secret_access_key $secret_access_key --profile <profile-name>
    aws configure set aws_session_token $session_token --profile <profile-name>
    aws configure set region us-east-2 --profile <profile-name>
EOF
