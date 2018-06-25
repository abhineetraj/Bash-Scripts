#!/bin/bash
touch /tmp/acc && :> /tmp/acc
# You can either pass the github username in the script or pass it as an argument
printf "\n Enter the password for the github account \n"
read pass
printf "\n Enter the username which needs to be searched in the collaborators\n"
read uid
for url in `cat /Users/abhineetraj/scripts/urls`
do
curl -s -u "github_username":$pass $url | grep $uid > /dev/null
if [ $? -eq 0 ]; then
corrurl=$(echo $url | awk -F "/" '{print $6 }')
echo " https://github.com/github_username/$corrurl/settings/collaboration" >> /tmp/acc
/usr/bin/open -a "/Applications/Google Chrome.app" "https://github.com/github_username/$corrurl/settings/collaboration"
#curl -X DELETE -i -u "user:pass" https://api.github.com/repos/user/repo/collaborators/john.doe
fi
done
cat /tmp/acc