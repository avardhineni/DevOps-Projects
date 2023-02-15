import boto3

ec2_client_us_east = boto3.client('ec2', region_name="us-east-1")
ec2_resource_us_east = boto3.resource('ec2', region_name="us-east-1")

ec2_client_pune = boto3.client('ec2', region_name="ap-south-1")
ec2_resource_pune = boto3.resource('ec2', region_name="ap-south-1")

instance_ids_us_east = []
instance_ids_pune = []

reservations_us_east = ec2_client_us_east.describe_instances()['Reservations']
for res in reservations_us_east:
    instances = res['Instances']
    for ins in instances:
        instance_ids_us_east.append(ins['InstanceId'])


response = ec2_resource_us_east.create_tags(
    Resources=instance_ids_us_east,
    Tags=[
        {
            'Key': 'environment',
            'Value': 'prod'
        },
    ]
)

reservations_pune = ec2_client_pune.describe_instances()['Reservations']
for res in reservations_pune:
    instances = res['Instances']
    for ins in instances:
        instance_ids_pune.append(ins['InstanceId'])


response = ec2_resource_pune.create_tags(
    Resources=instance_ids_pune,
    Tags=[
        {
            'Key': 'environment',
            'Value': 'dev'
        },
    ]
)
