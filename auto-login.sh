Regular Bash Script which calls the underlying Expect scrip

#!/bin/bash
cd /Users/abhineetraj/scripts
printf "\nEnter the password to decrypt\n"
read pass
echo "$pass" > /tmp/key
cp github_pass /tmp/temp_key
ansible-vault decrypt /tmp/temp_key --vault-password-file=/tmp/key
if [ $? -eq 0 ]
then
    password=`cat /tmp/temp_key`
    echo $password
    rm -rf /tmp/temp_key /tmp/key
    ./test-login.sh "$password"
else
  printf "Key to decrypt is Incorrect\n"
  rm -rf /tmp/temp_key /tmp/key
fi




cat test-login.sh

#!/usr/bin/expect -f
set password [lindex $argv 0]

ssh root@hostname
expect "PIN for abhineetraj:"
send "$password\r"
interact
