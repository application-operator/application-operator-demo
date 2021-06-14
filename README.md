# application-operator-demo

Application that demonstrates how application-operator can work

Deploys in the application namespace only for safety but can be
configured with a tweak to `namespace` in the kustomization.yaml
files under `test` and `prod`

Creating two `Application` resources in the cluster like:

```
kubectl apply -f - << EOF
apiVersion: application-operator.github.io/v1alpha1
kind: Application
metadata:
  name: test-docker-debug
  namespace: applications
spec:
  application: docker-debug
  environment: test
  version: blue
  method: demo
EOF
```

```
kubectl apply -f - << EOF
apiVersion: application-operator.github.io/v1alpha1
kind: Application
metadata:
  name: prod-docker-debug
  namespace: applications
spec:
  application: docker-debug
  environment: prod
  version: green
  method: demo
EOF
```

Will create a deployment with 1 replica for test, that will
run the blue version of docker-debug, and a deployment with
2 replicas for prod running the green version. Both have a 
different value for the `SECRET` environment variable.

This can be tested with
```
kubectl port-forward svc/test-docker-debug 8000:80
```
and then visiting `http://localhost:8000` to see the green
version.
