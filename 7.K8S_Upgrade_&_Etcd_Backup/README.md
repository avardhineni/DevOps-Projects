
### UPGRADING Kuberntes version 1.20.7 to 1.21.0 using Kubeadm

## In this demo:

1. We will upgrade kubernetes version 1.20.7 to 1.21.0 using "kubeadm"
2. In my setup, there is 1 master node and 2 worker nodes.

## Please read before performing the demo

a. These commands need to run on cluster running with Ubuntu 
b. Master and Worker nodes in your cluster might differ from this.
c. Kubernets version might be different in your case, but procedure is the same.
d. For more details, please visit Kubernetes docs.


## OVERVIEW: Steps involved in Kubernetes Version Upgrade:

1. Upgrade kubeadm
2. Upgrade Node
3. Drain the node (before kubelet upgrade)
4. Upgrade kubelet and kubectl
5. Restart the kubelet
6. Uncordon the node
7. Validate the Upgrade


## Upgrading MASTER(Control-Plane) Node(1).

0. Determine which version to upgrade to

`apt-cache madison kubeadm`


# Ugrading Kubeadm:

NOTE: If a package is marked "hold", it is held back: The package cannot be installed, upgraded, or removed until the hold mark is removed.

apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.21.0-00 && \
apt-mark hold kubeadm

kubeadm version


# Upgrading Node:

kubeadm upgrade plan
kubeadm upgrade apply v1.21.0



# Drain the node:

- Prepare the node for maintenance by marking it unschedulable and evicting the workload

kubectl drain master --ignore-daemonsets


# Upgrade "kubelet" and "kubectl":

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.21.0-00 kubectl=1.21.0-00 && \
apt-mark hold kubelet kubectl


# Restart the "Kubelet":

systemctl daemon-reload
systemctl restart kubelet


# Uncordon the node:

kubectl uncordon master




## Upgrading WORKER Node(1):

- The upgrade procedure on worker nodes should be executed one node at a time or few nodes at a time, without compromising the minimum required capacity for running your workloads.


# Upgrade kubeadm:

apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.21.0-00 && \
apt-mark hold kubeadm

# Upgrade "Node": (Run it on worker node)

- NOTE: For worker nodes this upgrades the local kubelet configuration:

kubeadm upgrade node


# "Drain" the node: (Run it on master node)

- Prepare the node for maintenance by marking it unschedulable and evicting the workloads:

kubectl drain worker-1 --ignore-daemonsets


# Upgrade kubelet and kubectl:

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.21.0-00 kubectl=1.21.0-00 && \
apt-mark hold kubelet kubectl


# Restart the kubelet:

systemctl daemon-reload
systemctl restart kubelet


# Uncordon the node:

- Bring the node back online by marking it schedulable:

kubectl uncordon worker-1


## Upgrading WORKER Node(2):

- Follow same above 6 steps as mentioned in "Upgrading WORKER Node(1)

# Verify the status of the cluster

- After the kubelet is upgraded on all nodes verify that all nodes are available again by running the following command from anywhere kubectl can access the cluster:

kubectl get nodes
kubeadm version
kubectl version
















