
# ETCD Database - Backup & Restore

## In this Article:

1. We will perform the Backup and Restore of ETCD Database.


## The need for BackUp:

1. We need backups to restore when there is disaster. For example if someone accidently deletes the namespace where deployments are resided.
2. To replicate the entire environment. 
3. Migration: If we need to migrate the Kubernetes cluster from one environment to other. 

### There are many ways to perform the backup & Restore. Here, I will use "etcdtl" command line tool. 
    Using this tool we can
- Create new entries
- delete the entries
- Take the snapshot of K8S Cluster information stored in ETCD database. 


## Ensure if "etcdctl" command line tool is available by running below command. 

```
export ETCDCTL_API=3
etcdctl version
```
If not available, we can follow the steps provided in the link:

`https://github.com/etcd-io/etcd/releases`

## Backup ETCD Database:

- Run the below command:

```
etcdctl --endpoints=https://127.0.0.1:2379 \
        --cacert=/etc/kubernetes/pki/etcd/ca.crt \
        --cert=/etc/kubernetes/pki/etcd/server.crt \
        --key=/etc/kubernetes/pki/etcd/server.key \
        snapshot save /opt/snapshot-28/02/2022-dev.db
```

- Check the status of backup:

```
etcdctl --write-out=table snapshot status /opt/snapshot-28/02/2022-dev.db
```

## Restore of ETCD Database:

- Run the below command: 

```
etcdctl  --data-dir /var/lib/etcd-from-backup \
         snapshot restore /opt/snapshot-28/02/2022-dev.db
```

## Update ETCD Data Directory

- To update new ETCD Data Directory location we need to update the ETCD Pod YAML file /etc/kubernetes/manifests/etcd.yaml
- Take the backup of the manifest file

`cp /etc/kubernetes/manifests/etcd.yaml /tmp/etcd.yaml.bak`

- Change the hostPath location in the manifest file:

```
- hostPath:
       path: /var/lib/etcd-from-backup   "Make sure this path is updated" 
       type: DirectoryOrCreate
     name: etcd-data
status: {}   
```

## Check "etcd-master" Pod Status

- Run the below command:
`kubectl get pods -n kube-system | grep etcd`

### If it is pending even after few minutes, try delete the etcd-master pod. Since this is "static pod", K8S will create from above etcd.yaml file

`kubectl delete pods etcd-master -n kube-system --grace-period=0 --force`

Wait for few mins and test the same.

`kubectl get pods -n kube-system | grep etcd`

## Articles to Read

- https://rancher.com/blog/2019/2019-01-29-what-is-etcd/
- https://www.redhat.com/en/topics/containers/what-is-etcd
- https://etcd.io/docs/v3.4.0/dev-guide/interacting_v3/
- https://github.com/etcd-io/etcd/
- https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/
- https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster







