# EKS Cluster Configuration

## Cluster Details
- **apiVersion**: eksctl.io/v1alpha5
- **kind**: ClusterConfig

### Metadata
- **Name**: `basic-cluster`
- **Region**: `us-west-2`
- **Version**: `1.32`

## Node Groups

### Node Group `ng-1`
- **Instance Type**: `t2.small`
- **Desired Capacity**: 1
- **Volume Size**: 20GB

### Node Group `ng-2`
- **Minimum Size**: 2
- **Maximum Size**: 2
- **Instance Distribution**:
  - **Max Price**: $0.0464
  - **Instance Types**: `["t3.small", "t3.medium"]`
  - **On-Demand Base Capacity**: 0
  - **On-Demand Percentage Above Base Capacity**: 0
  - **Spot Allocation Strategy**: "capacity-optimized"

## Availability Zones
- `["us-west-2a", "us-west-2b"]`

## Total Number of Instances
- **Node Group `ng-1`**: 1 instance of `t2.small`
- **Node Group `ng-2`**: 2 instances (either `t3.small` or `t3.medium`)
- **Total**: **3 Instances**

---


Now for demo lets use this config.yaml and create Kubernetes cluster

see main difference b/w yesterdays cluster configuration is todays is type of instances we used for cluster creation

In yesterday's cluster we did not sspecify any type so by default it takes ondemand instances

Reserved
Spot
On-demand

In todays class we are specifying desired capacity is 1 for ng -1 i.e. node 1

for node 2 i.e. ng-2 we specifed maxium and minimum size as 2 and allocated spot instance type 

so total it creates 3 instances 

Demo-1 (Name space creation dev and QA)

Now lets create EKS Cluster, steps would be
    Create EC2 Instance + 10 gb + 22 port + Attach a role with adminaccess policy attached
        Run install.sh  -> which Installs
            Kubectl
            eksctl
            awscli
    By using Cluster.yaml and eksctl we create EKS cluster ( with 2 nodes)


See for example you created yaml files for VOTE micro service application and deployed it in cluster

In Real world teams would have differnt environments DEV,TEST,QA,PROD
We cant have diffrent clusters for each environemnt
instead if we create same yaml files in the same cluster there would be chance of human errors
so to avoid that we use NAME-SPACE
Virtual cluster inside the physical cluster is called Name-space

Create vote app by using vote-service.yaml
kubectl apply -f vote-service.yaml
kubectl get pods

you have pods running all goood

Now lets use same yaml to deploy QA environment pods
kubectl apply -f vote-service.yaml

Nothing would change
deployment/vote unchanged
service/app unchanged


So you understand we cant create with same file now lets clean up pods
kubectl delete -f vote-service.yaml

jsut introudce -n
kubectl create namespace dev
kubectl create namespace prod
kubectl get ns
kubectl apply -f vote-service.yaml -n dev
kubectl apply -f vote-service.yaml -n prod


Demo-2 :

Problem statement:

  Lets say you have created two name spaces in a cluster
    DEV Name Space
      Vote pod
      Redis pod
    QA Name Space
      Vote pod
      Redis pod
  Now Question is if we access http://Redis From DEV Vote app which Redis the request goes to (DEV one or QA One) ?????

  https://Redis  form Vote app

  Solution is:

    We can't create redis two time in same name space, it should be unique, By default they goes to same Name space i.e. if 
    DEV Vote app ---> then DEV Redis
    QA Vote app ---> then QA Redis
If Dev Vote app wants to cmmunicate with QA Vote app, then we should use .namespace
    http://redis.qa
    DEV Vote app -----> QA Redis
    QA Vote app ----> QA Redis

    https://redis.dev
    DEV Vote app -----> DEV Redis
    QA Vote app -----> DEV Redis


Deploy vote and redis and see if you are able to vote
vote.yaml
redis.yaml

kubectl top pods
Ny default In EKS Metric server is not installed we need to install it in cluster

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml










### To delete cluster follow this pocedure if you run into any issues while deleting ####
kubectl get pdb -n kube-system
kubectl get pdb -n kube-system
kubectl get pods
kubectl drain ip-192-168-17-245.us-west-2.compute.internal --ignore-daemonsets --force --delete-emptydir-data
eksctl delete cluster -f cluster.yaml


