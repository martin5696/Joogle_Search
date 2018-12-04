import boto.ec2

conn = boto.ec2.connect_to_region("us-east-1")
key_pair = conn.create_key_pair ()
key_pair.save(".")


#reservation object containing instances
resp = conn.run_instances("ami-88aa1ce0", instance_type="t1.micro", key_name="joogle_key", security_groups=["csc326-group5"])
inst = resp.instances[0]
inst.update()

#gets all instances of this reservation object
resp.instances

#creae security groups
group = conn.create_security_group('joogle_security','security permissions')
group.authorize('ICMP', -1, -1, '0.0.0.0/0')	#ping server
group.authorize('TCP', 22, 22, '0.0.0.0/0')	#allow SSH
group.authorize('TCP', 80, 80, '0.0.0.0/0')	#allow HTTP
group.authorize('TCP', 8080, 8080, '0.0.0.0/0')# for standard port

#get all security groups
conn.get_all_security_groups()


#returns list of reservation object of running instances
resp = conn.get_all_reservaions()
resp = resp[0]
inst = resp.instances[0]
inst.update()

#terminates the instance
inst.terminate()


#PUBLIC-IP-ADDRESS is an attribute of class boto.ec2.instance.Instance
#use >>>inst.public_dns_name to get it. inst if an instance object.
ssh -i key_pair.pem ubuntu@<PUBLIC-IP-ADDRESS>

#run this in the normal terminal, NOT PYTHON SHELL to access instance
ssh -i joogle_key.pem ubuntu@ec2-54-165-24-200.compute-1.amazonaws.com

#copy file from local machine to aws instance
scp -i key_pair.pem <FILE-PATH> ubuntu@<PUBLIC-IP-ADDRESS>:~/<REMOTE-PATH>

#this copies one file to /home/ubuntu in the aws instance
scp -i Joogle_Search/joogle_key.pem Joogle_Search/urls.txt ubuntu@ec2-54-165-24-200.compute-1.amazonaws.com:~/

#this copies Joogle_Search directory to /home/ubuntu in the aws instance
scp -i Joogle_Search/joogle_key.pem -r Joogle_Search/ ubuntu@ec2-54-165-24-200.compute-1.amazonaws.com:~/

#one example of url where Joogle is deployed on an aws instance
http://ec2-54-165-24-200.compute-1.amazonaws.com


#install dependencies in newly created AWS instance to run Joogle
sudo apt-get update -y 
sudo apt-get install python-pip
pip install --upgrade --user pip
pip install --user httplib2
pip install --user beaker
pip install --user oauth2client
#pip install --user google-api-client
pip install --upgrade --user google-api-python-client
#TODO: change host and port to "0.0.0.0" and "80", this is for http
#need sudo because normal user has no permission to bind ports lower than 1024
sudo python joogle_search.py
#after the above is done, can access Joogle on: http://ec2-52-55-226-178.compute-1.amazonaws.com

#1. An active instance with your web application must be started and stay online for 1
#week from the due date of this lab. DONE
#2. You should provide a python script for launching a new instance on AWS. You may
#remove the ACCESS KEY and SECRET KEY in the submission files. Operations for
#binding an elastic IP does not need to be included in the script. DONE
#3.Security group must be name as “csc326-group<group_number>” DONE

ps -fA | grep python

TODO: For the deployed app on AWS, need to change:
- broken pipe stops my server (change ssh config and keepalive?)
- redirect_URI
	- google console
	- joogle_search.py
	- not sure how because I can't add http://0.0.0.0:80/redirect on google console


TODO: benchmarking
