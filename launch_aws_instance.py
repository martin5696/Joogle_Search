import boto.ec2
import time
import unicodedata

# Establisth connection with region us-east-1
conn = boto.ec2.connect_to_region('us-east-1')

# Run aws instance with key_name='joogle_key' and security_groups=['csc326-group5']
resp = conn.run_instances('ami-88aa1ce0', instance_type='t1.micro', key_name='martin_key', security_groups=['csc326-group5'])

inst = resp.instances[0]

# Need to insert delay because the instance takes some time to spin up
time.sleep(70)

inst.update()
public_dns = inst.public_dns_name

public_dns_ascii = unicodedata.normalize('NFKD', public_dns).encode('ascii', 'ignore')
print(public_dns_ascii)