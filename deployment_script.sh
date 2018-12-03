#!/bin/bash

#run using sh deployment_script.sh
#chmod u+x if this doesn't run
echo "	** Please wait while the aws instance spins up"
echo "	** This may take close to a minute"


# this launches a new instance and gets its DNS
# $public_DNS will store DNS of new instance

public_dns=$(python launch_aws_instance.py)

echo $public_dns

#copy joogle_search directory inside our instance
#scp -i key_pair.pem <FILE-PATH> ubuntu@<PUBLIC-IP-ADDRESS>:~/<REMOTE-PATH>

#SCRIPT="
#cd joogle_search;

# pip install ...
# ...

# ./launch_joogle.sh;

# exit;
# "

# #go into the instance, install packages, launch our site, then exit.
# ssh -i key_pair.pem ubuntu@<PUBLIC-IP-ADDRESS> "${SCRIPT}"

