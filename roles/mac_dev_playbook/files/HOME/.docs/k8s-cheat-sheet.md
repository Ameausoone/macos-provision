# Kubernetes

## Context & Namespace

```sh
kubectl config current-context
kubectl config set-context --current --namespace=<namespace>
kubectl config get-contexts
```

## Inspect

```sh
kubectl get nodes -o wide
kubectl get pods -A                              # all namespaces
kubectl get all -n <namespace>
kubectl describe pod <pod>
kubectl logs <pod> [-c <container>] [-f]
kubectl exec -it <pod> -- /bin/sh
```

## Deploy

```sh
kubectl apply -f <file.yaml>
kubectl create deployment <name> --image=<image> --replicas=2
kubectl scale deployment/<name> --replicas=5
kubectl rollout status deployment/<name>
kubectl rollout undo deployment/<name>           # rollback
```

## Pod (one-off)

```sh
kubectl run <name> --image=<image> --restart=Never   # create pod (not deployment)
kubectl run <name> --image=<image> --rm -it -- sh    # ephemeral debug pod
```

## Service

```sh
kubectl expose deployment <name> --type=LoadBalancer --port=80
kubectl port-forward svc/<name> 8080:80
```

## Secret & ConfigMap

```sh
kubectl create secret generic <name> --from-literal=key=value
kubectl create configmap <name> --from-file=<file>
kubectl get secret <name> -o jsonpath='{.data.key}' | base64 -d
```

## Taint & Toleration

```sh
kubectl taint nodes <node> key=value:NoSchedule
kubectl taint nodes <node> key:NoSchedule-         # remove taint
```

```yaml
# toleration in pod spec
tolerations:
  - key: "key"
    operator: "Equal"
    value: "value"
    effect: "NoSchedule"
```

## Cleanup

```sh
kubectl delete pod <pod> --grace-period=0 --force
kubectl delete all --all -n <namespace>
```
