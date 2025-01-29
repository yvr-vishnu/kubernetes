Minikube Installtion prerequisite
    Install atleast t2.medium ec2 instance with 20 gb disk space ubuntu  
    install
        docker ( Make sure ubuntu user is added to docker group)
        kubectl ( kubectl-install.sh )
        minikube

Automating the Minikube full install
chmod +x Minikube-full-install
install-docker.sh
logout and log back -> reason is we have added ubuntu to docekr group we need to log in back to take effect
install-kubectl-minikube.sh

Just run final script which will install all the required packages
Install-dkr-kubectl-minkb.sh

## To list nodes ##
kubectl get nodes

## To create POD ##
kubectl run nginx --image nginx

## To list PODS ##
kubectl get pods
kubectl delete pod nginx

## To access pod ##
kubectl exec -it nginx -- /bin/bash


kubectl logs -f ngnix

## To deploy pod.yml ##
kubectl apply -f pod.yml