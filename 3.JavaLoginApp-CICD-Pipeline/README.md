# This Project is an complete CI/CD Automation Project.

- I'm using Jenkins to automate Build & Deployment Pipelines also called as CI & CD Pipelines.
- Below image depicts the overview of the CI/CD Pipeline Project.

<img src="images/cicd-pipeline.png" width="800">

1. Developer commits the code to the Bit Bucket repository in the respective branches.
2. Once the code is approved and merged to specific branch, The role of DevOps engineer will start. 
3. Jenkins acts as a DevOps engineer and performs build and deployment. All I have to do is configure the Jenkins Server with correct configurations.
4. Jenkins will take the code from Bit Bucket, do the Maven build, push the code for SonarQube analysis, once the quality gate is passed, the artifact will be pushed to JFrog artifactory. 
5. With the help of Ansible Play books, jenkins will create a Docker container image from the artifact in Jfrog Artifact and publish it to the docker registry. 
6. This image is used to deploy into specific namespaces through Kubernetes. 

But, having the CI & CD pipelines combined is not a best practice. As a best practice, I will split the Pipeline into 2 pipelines, one for CI Pipeline and other for CD pipeline. 

## CI Pipeline


<img src="images/ci-pipeline.png" width="800">

1. In the CI pipeline, the role of the Jenkins is to clone the bit bucket repository code, perform the maven build process, push the code for SonarQube analysis, once the quality gate is passed, the artifact is pushed to JFrog artifactory. 
2. Jenkins will execute ansible playbook to create the Docker container image from the artifact and publish it to the docker hub registry.
3. I need to create Kubernetes deployment, service manifest files.  
4. Jenkins will create the helm charts. In this helm chart, the values are not hard coded. The values will be variablised according to the environment type. 
5. The helm charts are again pushed to JFrog artifactory. 

## CD Pipeline


<img src="images/cd-pipeline.png" width="800">

1. Once the Integration is done and helm chart is available in artifactory, I need to perform the deployment into various environments one by one, at first Dev environment.
2. Prepare the values.yaml file for each environment, and commit the multiple values.yaml files into 2nd bit bucket repository. 
3. In here, I will create multiple branches for each environment type and have values.yaml file created for each branch. 
4. The pipeline will fetch the required files from the bit bucket for each environment type and go to artifactory to download the helm charts and apply the values from values.yaml file at the time of deployment to specific environment. 

In this entire process, CI pipeline job will run one time and CD pipeline job will run 4 times as per the environment type. The pipeline will not deploy in all the environment at once. At first the code is deployed in to Dev environment. After the validation and approvals, the code is deployed into QA environment. Again after the validation and approvals the same process will continue till deployment into Production environment. 

All the above configurations is specified in the Jenkinsfile in the declarative way.

# Implementation of CI/CD Pipelines


## Phase 1: Planning 

### A. Planning Tools

<img src="images/planning-tools.png" width="600">

At first, before implementing planning is very important.

1. I need to identify what are the tools I need to configure in the Jenkins server to implement CI/CD pipelines. 
2. For CI pipeline I need to install JDK, Maven, Git. 
3. For configuring SonarQube and JFrog nothing has to be installed, All the commands are ran from Maven.
4. For CD pipelines I need to install Ansible, Docker, Docker_py, Kubectl, Helm.

As of now I am installing all these tools in Jenkins control node. If using Jenkins Agent, I need to make sure that all these components are installed in each slave node.

### B. Planning for Credentials

<img src="images/Planning-Creds.png" width="500">

I have to supply the required credentials to Jenkins to authenticate with different tools. 
I need to provide credentials for 
1. BitBucket 
2. SonarQube Token 
3. Jfrog 
4. Docker Hub Registry (Ansible) 

### C. Planning for Jenkins Plugins

<img src="images/Planning-Plugins.png" width="500">

The Plugins need to be configured are
1. Git/Maven (Already Installed)
2. Sonar 
3. Jfrog artifactory

Depending on my project scenario, I am not installing Ansible plugin as I need Ansible to run a playbook file.

### D. Planning for Configuration files

<img src="images/Planning-conf-files.png" width="600">

1. I need to provide Ansible playbook to Jenkins, so that it can fetch the artifact from Jfrog artifactory and creating the docker image and push it to docker hub registry.
2. I need to provide a Dockerfile to Ansible Playbook, the playbook will use the Dockerfile so that it can create an docker image. The Dockerfile will point to the artifact that it had to load while creating the image. 
3. I need to provide the Kubernetes deployment, service manifest files to helm in the specified helm directed hierarchy. The manifest files are variabilize and data is fetched from values.yaml file.
4. All the above configuration files along with Source Code (already committed by Developer) has to be committed to bitbucket repository used for CI Pipeline. 

Ideally, while planning for Automation, At first I need to execute it manually and identify the requirements. Once I identified the dependencies, ran the steps manually, then start Automating the process.  

5. Now, in order to inform Jenkins to execute the steps in orderly manner, I need to provide Jenkinsfile with all the instructions discussed above in a loosely coupled manner (Stages) i.e. a declarative pipeline.


## Phase 2: Execution of CI Pipeline

1. At first login to the Jenkins and make sure all the tools are installed. 
2. While installing kubectl, I have to make sure that it is pointing to kubernetes control plane API server. 
3. After installing Helm, I also need to install plugin "Plugin-Artifactory" so that helm charts can be pushed to JFrog artifactory.
4. Currently I am preparing the infrastructure part. This can also be done through Terraform or Ansible. In this project, I am not doing Infrastructure automations, as I have already done Infrastructure automation in the 1st project, at present main focus is on Application automation. 
5. I have installed Jenkins plugins as mentioned above after installing all the tools. 
6. Once the plugins are installed, need to store the credentials for GIT, Sonar Token, & JFrog under Credentials Manager in Jenkins Server. 
7. I also need to edit the pom.xml file by adding SonarCloud properties and distribution management settings of JFrog. 
8. Now create the Dockerfile. In the Dockerfile, it will get the lastest tomcat image from the docker registry and copy my customized .war file to tomcat webapps folder and create an image out of it. 
9. Create the Ansible playbook to automate the container image. In the Ansible playbook, the 1st task is to pull the artifact from the JFrog, 2nd task is to rename the .war file to simple name, 3rd task is to perform the build process to create the docker image, the path to fetch the Dockerfile is pwd, 4th task is to login to the docker hub, and final task is to push the image into the docker hub.
10. Create the deployment and service manifest files for helm charts. These files are available helm charts folder as helm designated folder structure. The values are variabilized to support various environment types. 
11. Now before creating Jenkinsfile, I need to perform tool configuration by supplying the endpoints of maven, sonarqube, Jfrog by navigating to Configure System under Manage Jenkins. Maven configuration can be found in Global tool configuration. 
12. Create the Jenkins file with various stages in it.
    - Stage 1: Performs the Git clone process. The code will come to build server.
    - Stage 2: Build Stage, here I am running mvn package command from the folder java-source as it has source code and pom.xml file.
    - Stage 3: The next stage is related to SonarQube code analysis. 
    - Stage 4: It is related to JFrog configurations. 
    - Stage 5: This stage is publishing build information. 
    - Stage 6: This stage will run the Ansible Playbook to create the docker image and push the image to docker hub. 
    - Stage 7: The last stage is to prepare the helm charts. I am running the helm package commands from helmcharts folder. This will create the helm charts and to publish   
               the helm charts to jfrog artifactory mentioned the command helm push-artifactory. Also create another repository to hold the helm charts. 
13. Now in the Jenkins server, create a new Pipeline job. Provide the Jenkinsfile path in the Pipeline script from SCM. 

<img src="images/Pipeline.png" width="600">

     Jenkins server will go to this repository, get the code from master branch and look for Jenkinsfile and start execute it. 
     
14. In order to trigger the job automatically, I can configure webhook or poll scm option. This will also trigger automatically whenever there is a change in code as well. As of now I am running the Pipeline job manually. 
15. And my first build job failed and digging into details to check why it got failed.
16. I found a small typo in the Jenkinsfile, corrected it and running the pipeline job again.

<img src="images/pipeline-view.png" width="600">

<img src="images/stageview.png" width="600">

17. And again the build is failed at the Deploy Artifact stage. It is not able to publish the artifact to JFrog artifactory eventhough the maven build is successfull. 
18. To troubleshoot this I will run this step manually to isolate the issue. 
19. After troubleshooting for a while, I have found that repository name JFrog artifactory was given wrong. Also found that location of the helm was wrong. 
20. As I have fixed both the issues, I have once again started the CI Pipeline job and build got success.

<img src="images/CI-Build-Success.png" width="600">


## Phase 3: Execution of CD Pipeline

1. At first create a seperate repository for CD pipeline and create branch for each environment type for eg. Dev, QA, Perf, PROD.
2. In this repository I need to have values.yaml file and Jenkinsfile. In the values.yaml file, I need to provide values for each environment type.
3. In the Deployment Jenkinsfile, at first defining the variables like label, namespace, environm and has two stages. 
4. In the 1st stage, I am cloning the deployment repository and getting the data from Dev branch as it has the values.yaml file for Dev environment specifications.
5. In the 2nd stage, I am calling out helm commands to perform the actual deployment such as helm repo add, helm repo update, helm upgrade.
6. Simillarly, I need to have the values.yaml for other environments as well and in Jenkinsfile for each environment I need to update only the namespace, environ & branch type.
7. Now, create a Multibranch Pipeline to run the CD Pipeline as it has multiple branches. It will scan all the branches present in the repository, get the Jenkinsfile and perform the deployment. 
8. As I can see all the environments all I have to do is click Build now on each environment. This is called Continuous Delivery Model.

<img src="images/all-cd-env.png" width="600">

9. If we get a callout to run the Dev environment pipeline, Click on Build now and it will take Helm chart from the JFrog, apply the values from values.yaml file and deploy it into the respective namespace.
10. The build was failed due to some small folder misconfigurations. So, I didn't discussed over here.
11. After the changes, deployment to dev environment is successfull.

<img src="images/dev-env.png" width="600">


12. The same way I had done deployed in the QA, Perf, production through respective branches. It will get neccessary values from values.yaml file and deploy it in respective namespace.

<img src="images/all-branch.png" width="800">

13. In case of any code change, only the CI Pipeline will run. CD Pipeline will not run. CD Pipeline can be also called as single click deployment. Once I get a callout to run the Dev CD Pipeline, development team will available to validate and if it is successfull, I will get a callout to run QA CD Pipeline after taking neccessary approvals. QA team will validate the deployment and the same is repeated till the application is deployed into the Production environment. 

14. This is one of the method to implement CI/CD Pipelines to deploy an application. There are many other methods, it all depends on the project, technology stack that we are selecting and many other factors. Our end goal should be to deploy an application that has High Availability, Scalability, Disaster Recovery.

# Thank You

