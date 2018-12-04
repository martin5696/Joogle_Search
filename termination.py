import boto.ec2

# Establisth connection with region us-east-1
conn = boto.ec2.connect_to_region('us-east-1')

# Run aws instance with key_name='joogle_key' and security_groups=['csc326-group5']
resp = conn.run_instances('ami-88aa1ce0', instance_type='t1.micro', key_name='martin_key', security_groups=['csc326-group5'])

inst = resp.instances[0]

resp = conn.get_all_reservaions()
resp = resp[0]
inst = resp.instances[0]
inst.update()

#terminates the instance
inst.terminate()