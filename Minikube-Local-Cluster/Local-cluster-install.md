Minikube Installation and Usage Guide
Prerequisites for Minikube Installation
EC2 Instance:

Instance Type: t2.medium(at least)

Disk Space: 20 GB

OS: Ubuntu

Install the Following:

Docker: Ensure the ubuntu user is added to the docker group.

Kubectl: Use the script kubectl-install.sh.

Minikube

Automating the Minikube Installation
Make the Installation Script Executable:

sh
chmod +x Minikube-full-install
Install Docker:

sh
./install-docker.sh
Log out and Log Back In:

This step is necessary to apply the changes to the docker group.

Install Kubectl and Minikube:

sh
./install-kubectl-minikube.sh
Run the Final Installation Script:

sh
./Install-dkr-kubectl-minkb.sh
Basic Minikube Commands
List Nodes:

sh
kubectl get nodes
Create a Pod:

sh
kubectl run nginx --image nginx
List Pods:

sh
kubectl get pods
Delete a Pod:

sh
kubectl delete pod nginx
Access a Pod:

sh
kubectl exec -it nginx -- /bin/bash
View Pod Logs:

sh
kubectl logs -f nginx
Deploy from a YAML File:

sh
kubectl apply -f pod.yml
Let me know if you need any further tweaks or additions!