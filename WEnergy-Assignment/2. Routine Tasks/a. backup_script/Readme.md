To use the script "backup_script", follow the steps below:

- Make the script executable by running the following command: chmod +x backup_script.sh.
- Execute the script by running ./backup_script.sh [RETENTION_COUNT], where [RETENTION_COUNT] is an optional parameter that specifies the number of files to keep for retention. If not specified, it will default to 8.

After executing the script, it will perform the following actions:

- It will create a zip archive of all the files in the ./data directory. The filename of the archive will be based on the current timestamp in UTC.
- The archive will be stored in the ./backups directory.
- The script will apply the retention policy by deleting the oldest files in the ./data directory if the file count exceeds the retention count specified or the default count of 8.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

To ensure the script works correctly, please follow the steps mentioned below for the AWS S3 addition (Bonus Task):

- Replace the placeholders YOUR_ACCESS_KEY, YOUR_SECRET_ACCESS_KEY, and YOUR_BUCKET_NAME in the script with your actual AWS access key, secret access key, and bucket/container name, respectively.

- Make sure you have the AWS CLI installed. If not, please install it.

- Configure the AWS CLI with the appropriate credentials by running aws configure --profile myprofile in the terminal. This command will create a profile named "myprofile" in the AWS CLI configuration, which will be used in the script.

- When prompted, enter your AWS Access Key ID, AWS Secret Access Key, default region, and output format. Provide the corresponding values based on your AWS account configuration.

- Once you have updated the script and configured the AWS CLI, you can run the script using the following command:

./updated_backup_script.sh 10

- Replace 10 with your desired retention period. If you omit the retention period parameter, it will default to 8 as specified in the script.

- After configuring the profile, the AWS CLI will utilize the specified credentials when executing the "aws s3 cp" command in the script.
