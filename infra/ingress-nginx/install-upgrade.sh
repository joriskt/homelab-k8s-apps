#!/bin/bash

helm upgrade \
    --install ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --namespace ingress-nginx \
    --create-namespace \
    ingress-nginx
