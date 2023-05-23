To generate an export of all instances of running EC2 machines across multiple AWS accounts mapped to a root account, you can use the AWS SDK for Python (Boto3) and assume a role in each account to retrieve the EC2 instances.

In the script, please replace 'account_id1', 'account_id2', 'account_id3' with the AWS account IDs, and also update role name at:
f'arn:aws:iam::{account_id}:role/YourRoleName'

To run the script:

Install Python, Boto3 library.
Run the command "python 1.all_ec2_running_status.py"

The script will start running, assuming the roles in each AWS account, retrieving the running EC2 instances information for each account.



