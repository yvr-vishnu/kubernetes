Setting Up a Kubernetes Cluster with Minikube and EKS
Minikube
Minikube is a local Kubernetes cluster that provides the same capabilities as a Kubernetes cluster in a single-node architecture. Practice installing and writing basic YAML files to understand the syntax and usage.

Installing Kubernetes (EKS) Cluster
For production and real-world usage, we will install a Kubernetes EKS (Elastic Kubernetes Service) cluster, which has advanced capabilities.

Cost Considerations
EKS Cluster Deployment: Charged on an hourly basis, usually costing around $75 per month (~₹5,000).

EKS Cluster Creation Time: Takes approximately 20 minutes. Avoid mistakes to minimize costs.

EC2 Instance Requirements
Instance Type: T2.Medium at minimum.

Storage: At least 10 GB.

Ports: Ensure Port 22 is open.

IAM Role: Assign an IAM Role with AdminAccess to the EC2 machine to manage network components.

Prerequisites for EKS Cluster on EC2 Machine
Install the following packages:

Kubectl

EKSctl

AWS CLI

Attach an IAM Role with AdminAccess to the EC2 machine. Run the Install-eks.sh script to install all prerequisites.

Create Cluster Configuration
Create a file named cluster-conf.yaml on the EC2 machine.

Creating the EKS Cluster
Use the following command to create the cluster with the default configuration:

sh
eksctl create cluster
To use your custom cluster-conf.yaml configuration file, run:

sh
eksctl create cluster -f cluster-conf.yaml
Notes
AWS uses CloudFormation (CFT) for Infrastructure as Code (IAC). Behind the scenes, it uses CFT to launch the cluster. Please wait for 20 minutes as cluster creation takes approximately 20 minutes.

Interacting with the Cluster
Once the installation is complete, interact with the cluster using kubectl. You should see 2 nodes:

sh
kubectl get nodes
kubectl get pods
Creating and Managing Pods and Deployments
Create a Pod
Create a pod.yaml file and apply it:

sh
kubectl apply -f pod.yaml
Access a Pod
sh
kubectl exec -it nginx -- /bin/bash
Delete a Pod
sh
kubectl delete pod nginx
Create a Deployment
Create a deployment.yaml file and apply it:

sh
kubectl apply -f deployment.yaml
Delete a Pod in the Deployment
sh
kubectl delete pod nginx-ddf5df559-gdtbz
This will create a new pod in place of the deleted one.

Communication in Kubernetes
Kubernetes communication can be internal (component to component or pod to pod) or external. Pod IPs cannot be relied upon since they change when pods are recreated. This is why we use services in Kubernetes, which are virtual components that receive requests and load balance them.

Internal Traffic: One service to another.

External Traffic: From outside the cluster.

Types of Services
Cluster IP

NodePort

LoadBalancer

Creating and Using Services
Create a service.yaml and add this to your deployment configuration. Apply the configuration:

sh
kubectl apply -f deployment-vote.yaml
List the services:

sh
kubectl get service
You will see a new LoadBalancer service created. The actual load balancer will be created under AWS → LoadBalancer. You can use the DNS name to access it:

a7809e10a06c64ba7b68a608c58423de-1243896997.us-west-2.elb.amazonaws.com
You should be able to see the app!

Managing Services
For every microservice, create two files:

deployment.yaml (for creating pods)

service.yaml (for load balancing pods)

Create a service.yaml for nginx with service type as ClusterIP. Apply the configuration:

sh
kubectl apply -f nginx-service.yaml
List the pods and services:

sh
kubectl get pods
kubectl get service
You will see the ClusterIP service, but it cannot be accessed externally.

Testing Internal Communication
Access any vote pod:

sh
kubectl exec -it vote-789c8c876f-2gnsr -- /bin/sh
wget -qO- http://nginx
wget -qO- http://cluster-ip
Or use a busybox pod:

sh
kubectl exec -it busybox -- sh
wget -qO- http://nginx
This demonstrates how one service can communicate with another within Kubernetes.

Deleting the EKS Cluster
To delete the EKS cluster:

sh
eksctl delete cluster -f cluster.yaml
