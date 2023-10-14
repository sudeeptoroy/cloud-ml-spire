helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update


# create security cluster
openssl rand -hex 32

kubectl get storageclass

#helm install jhub-datascience jupyterhub/jupyterhub -f scipy-jhub-values-kind.yaml -n jupyter --create-namespace --timeout 180s

touch config.yaml

#helm upgrade --cleanup-on-fail \
#  --install hub jupyterhub/jupyterhub \
#  --namespace jupyter \
#  --create-namespace \
#  --values helm-values.yaml


helm upgrade --cleanup-on-fail \
  --install hub jupyterhub/jupyterhub \
  --namespace jupyter \
  --create-namespace \
  --values helm-values-aws.yaml

kubectl get po -n jupyter -w 
kubectl get deploy,po,svc,pvc -n jupyter

kubectl port-forward -n jupyter svc/proxy-public 8080:80 &

http://localhost:8080
