import boto3

# List of AWS account IDs to include
account_ids = ['account_id1', 'account_id2', 'account_id3']

# Assume a role in each account and retrieve EC2 instances
for account_id in account_ids:
    # Assume a role in the account
    sts_client = boto3.client('sts')
    role_arn = f'arn:aws:iam::{account_id}:role/YourRoleName'  # Replace 'YourRoleName' with the appropriate role name
    assumed_role = sts_client.assume_role(RoleArn=role_arn, RoleSessionName='AssumedRoleSession')

    # Create a session using the assumed role credentials
    credentials = assumed_role['Credentials']
    ec2_client = boto3.client(
        'ec2',
        aws_access_key_id=credentials['AccessKeyId'],
        aws_secret_access_key=credentials['SecretAccessKey'],
        aws_session_token=credentials['SessionToken']
    )

    # Retrieve running EC2 instances
    response = ec2_client.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

    # Process and export the instance data as per the requirements
    instances = response['Reservations']
 

    # Print the instance information for demonstration
    print(f'Instances in account {account_id}:')
    for reservation in instances:
        for instance in reservation['Instances']:
            print(f'Instance ID: {instance["InstanceId"]}, Instance State: {instance["State"]["Name"]}')


