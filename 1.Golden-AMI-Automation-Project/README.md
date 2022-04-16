# Golden AMI Creation

For creating Golden AMI, Packer uses base AMI and what we do manually to create Golden AMI, Packer will also do the same but in Automated way. 

Packer will create an EC2 instance, 
Log in to the EC2 instance, 
Install the required packages 
Create the AMI and terminate the EC2 instance. 

1. Intall standard packages - git, awscli, java, unzip etc... 
2. Install Apache Tomcat - 
3. ansadmin - user
4. publickey - 
5. Cloudwatch agent for memory utilization

To Execute the process, run the below command:
```
packer.exe build -var-file build/variables.json build/javaloginapp.json
```
In case of any errors, to debug the execution, run the below command:
```
packer.exe build -debug -var-file build/variables.json build/javaloginapp.json
```