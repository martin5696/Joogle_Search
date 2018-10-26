import boto.ec2

conn = boto.ec2.connet_to_region ('us-east-1')


resp = conn.run_instances('ami-88aa1ce0', instance_type='t1.micro', key_name='joogle_key', security_groups=['csc326-group5'])
# instance_id = resp['Instances'][0]['InstanceId']
# ec2.start_instances(InstanceIds=[instance_id])