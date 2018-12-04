#!/bin/bash

#commands that will be ran automatically inside AWS instance
SCRIPT="
sudo apt-get update -y
sudo apt-get install python-pip -y
pip install --upgrade --user pip
pip install --user httplib2
pip install --user beaker
pip install --user oauth2client
pip install --upgrade --user google-api-python-client
sudo pip install BeautifulSoup4
pip install redis --user
sudo apt-get install redis-server -y
sudo wget http://download.redis.io/redis-stable.tar.gz
sudo tar xvzf redis-stable.tar.gz
cd redis-stable
make
make install
cd ../joogle_search/
sudo sh launch_joogle.sh
"

#run using sh deployment_script.sh
#chmod u+x if this doesn't run
echo "	** Please wait while the aws instance spins up"
echo "	** This will take around 1 minute"

# this launches a new instance and gets its DNS
# $public_DNS will store DNS of new instance

public_dns=$(python launch_aws_instance.py)
echo "	** The instance has been started and the DNS address fetched"
echo "	** public_dns: $public_dns"

#permissions were too open??
# might not need this since it's already changed
chmod 400 joogle_key.pem
sshServer="ubuntu@$public_dns"

echo "	** Uploading our program to AWS instance"
#copies scp_recursive/ into root directory of instance
#assuming you are inside the root directory of the project
scp -o StrictHostKeyChecking=no -i joogle_key.pem -r ../joogle_search "$sshServer":~/
echo "	** program uploaded successfully to AWS instance"

echo "	** Accessing AWS instance through SSH server: $sshServer"
echo "	** AWS instance $sshServer accessed successfully"
echo "	** Installing dependencies on AWS instance and starting our program. This may take a few minutes."

ssh -i joogle_key.pem "$sshServer" "${SCRIPT}"

echo "Program successfully started. You can access it from here: $public_dns"







#ssh -i martin_key.pem ubuntu@ec2-18-214-100-115.compute-1.amazonaws.com
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

