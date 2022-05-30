#!/bin/bash
#

echo "deploy marp container"

kubectl apply -f deployment.yaml --namespace r-mordasiewicz

echo "kubectl exec --namespace r-mordasiewicz -it marp -c marp -- /bin/sh"
