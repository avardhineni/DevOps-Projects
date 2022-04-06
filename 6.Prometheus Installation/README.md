# Configure Prometheus in Kubernetes on Microservices Application.

The most efficient method of deploying Prometheus is through Helm and Operator - That manages Kubernetes cluster.
Helm will perform the initial setup and 
Operator manages the Kubernetes cluster setup.

## Pre-requisites 
 - Install and configure aws cli.
 - Install eksctl.
 - Install Helm.

## Installation Steps

  - To create an EKS Cluster, run the command
    ''' eksctl create cluster
    The cluster should be up and running in 10 - 15 mins.
  - Create a namespace for Microservice Application
    ''' Kubectl create namespace online-cart
  - Deploy Kubernetes Cluster
    ''' kubectl apply -f ms-appplication.yaml -n online-cart
  - For deploying Prometheus, Create a seperate namespace. This will have a nice seperation between Microservice application and Prometheus.
    ''' Kubectl create namespace monitoring
  - Now deploy a monitoring stack that would monitor cluster and applications using Helm chart.
  - Add Helm Repository where the chart is located.

### Deploy Prometheus Operator Stack
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring

[Link to the chart: https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack]

### Check Prometheus Stack Pods
    kubectl get all -n monitoring

### Access Prometheus UI
    kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090 -n monitoring &

### Access Grafana
    kubectl port-forward svc/monitoring-grafana 8080:80 -n monitoring &
    user: admin
    pwd: prom-operator

### Access Alert manager UI
    kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093 &

 

