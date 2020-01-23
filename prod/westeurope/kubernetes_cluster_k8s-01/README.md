# Kubernetes how-to

## Cleanup: delete previous contexts

```shell
kubectl config unset contexts.dpt-services-prod-aks-k8s-01
kubectl config unset clusters.dpt-services-prod-aks-k8s-01
kubectl config unset users.clusterUser_dpt-services-prod-rg_dpt-services-prod-aks-k8s-01
```

## Download a new cluster configuration and switch context

```shell
# List clusters
az aks list

# Get kube config file (merges it with .kube/config)
az aks get-credentials -n dpt-services-prod-aks-k8s-01 -g dpt-services-prod-rg

# Switch context
kubectl config use-context dpt-services-prod-aks-k8s-01

# Query K8S for existing pods
kubectl get pods
```

## See Kubernetes dashboard

```shell
az aks browse --resource-group dpt-services-prod-rg --name dpt-services-prod-aks-k8s-01
```

# Kubernetes cluster configuration

All Kubernetes cluster configurations are available at [this repository](https://github.com/teamdigitale/dpt-services-infra-post-config).
