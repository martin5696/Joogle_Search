import boto.ec2

# Establisth connection with region us-east-1
conn = boto.ec2.connect_to_region('us-east-1')

resp = conn.get_all_reservations()
resp = resp[0]
inst = resp.instances[0]
inst.update()

#terminates the instance
inst.terminate()