#!/bin/bash

# $public_DNS will store DNS of new instance
# launch_aws.py will have to print the public_DNS to stdout
# this launches a new instance and gets its DNS
public_DNS = $(python launch_aws.py)

#copy joogle_search directory inside our instance
scp -i key_pair.pem <FILE-PATH> ubuntu@<PUBLIC-IP-ADDRESS>:~/<REMOTE-PATH>

SCRIPT="
cd joogle_search;

pip install ...
...

./launch_joogle.sh;

exit;
"

#go into the instance, install packages, launch our site, then exit.
ssh -i key_pair.pem ubuntu@<PUBLIC-IP-ADDRESS> "${SCRIPT}"

