This Project is an complete CI/CD Automation Project.

I'm using Jenkins to automate Build & Deployment Pipelines also called as CI & CD Pipelines.

Below image depicts the overview of the CI/CD Pipeline.

<img src="images/cicd-pipeline.png" width="800">

1. Developer commit the code to the Bit Bucket repository in the respective branches.
2. Once the code is approved and merged to specific branch, The role of DevOps engineer will start. 
3. Jenkins acts as a DevOps engineer and performs build and deployment. All I have to do is configure the Jenkins Server with correct configurations.
4. Jenkins will take the code from Bit Bucket, do the Maven build, push the code for SonarQube analysis, once the quality gate is passed, the artifact will be pushed to JFrog artifactory. 
5. With the help of Ansible Play books, need to create a Docker container image from the artifact in Jfrog Artifact and publish it to the docker registry. 
6. This image is used to deploy into specific namespaces through Kubernetes. 

But, having the CI & CD pipelines combined is not a best practice. As a best practice, I will split the Pipeline into 2 pipelines, one for CI Pipeline and other for CD pipeline. 

CI Pipeline

<img src="images/ci-pipeline.png" width="800">

1. In the CI pipeline, the role of the Jenkins is to clone the bit bucket repository code, perform the maven build process, push the code for SonarQube analysis, once the quality gate is passed, the artifact is pushed to JFrog artifactory. 
2. Jenkins will execute ansible playbook to create the Docker container image from the artifact and publish it to the docker hub registry.
3. I need to create Kubernetes deployment, service manifest files.  
4. Jenkins will create the helm charts. In this helm chart, the values are not hard coded. The values will be variablised according to the environment type. 
5. The helm charts are again pushed to JFrog artifactory. 

CD Pipeline

<img src="images/cd-pipeline.png" width="800">

1. Once the Integration is done and helm chart is available in artifactory, I need to perform the deployment into Dev environment. 
2. Prepare the values.yaml file for each environment, and commit the multiple values.yaml files into 2nd bit bucket repository. 
3. In here, I will multiple branches for each environment type and have values.yaml file created for each branch. 
4. The pipeline will fetch the required files from the bit bucket for each environment type and go to artifactory to download the helm charts and apply the values from values.yaml file at the time of deployment to specific environment. 

In this entire process, CI pipeline job will run one time and CD pipeline job will run 4 times as per the environment type. The pipeline will not deploy in all the environment at once. At first the code is deployed in to Dev environment. After the validation and approvals, the code is deployed into QA environment. Again after the validation and approvals the same process will continue till deployment into Production environment. 
