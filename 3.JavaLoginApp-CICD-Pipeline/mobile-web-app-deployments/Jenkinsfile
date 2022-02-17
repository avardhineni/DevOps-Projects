pipeline {

  environment {
    label = "deploy-mobile-web-app"
    namespace = "qa"
    environ = "qa"
  }
  agent any

    stages {

      stage ('Checkout SCM'){
        steps {
          checkout([$class: 'GitSCM', branches: [[name: '*/qa']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git', url: 'https://iwayqtech@bitbucket.org/iwayqtech/mobile-web-app-deployments.git']]])
        }
      }
	  
	  stage ('Deploy Helm Charts')  {
	      steps {
           sh "sudo /usr/local/bin/helm version"
          
           dir("iwayq-web-app"){
                    sh 'pwd'
                    sh "sudo /usr/local/bin/helm repo add mobile-local https://iwayqweb.jfrog.io/artifactory/mobile-helm-local --username prreddy1986@gmail.com --password mko09ijN"
                    sh "sudo /usr/local/bin/helm repo update"
                    sh "sudo /usr/local/bin/helm upgrade iwayq-web-app-${environ} --install --namespace ${namespace}  --force ."
                    sh "sudo /usr/local/bin/helm list -a --namespace ${namespace}"
                }
        }
         
      }
         
   } 
}