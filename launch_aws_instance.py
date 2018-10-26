import boto.ec2

conn = boto.ec2.connect_to_region('us-east-1')

resp = conn.run_instances('ami-88aa1ce0', instance_type='t1.micro', key_name='joogle_key', security_groups=['csc326-group5'])
