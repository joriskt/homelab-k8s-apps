# infra

Alles wat nodig is om een cluster succesvol te draaien, m.u.v. een paar resterende dingen in de `homelab-k8s-infra` repository.

```bash

# ArgoCD installeren:
$ k create ns argocd
$ k apply -k apps/argocd/overlays/production -n argocd

# Zorgen dat ArgoCD zichzelf update:
$ k apply -f apps/argocd/argo/production.yaml

# ArgoCD de infra laten installeren:
$ k apply -f infra/metallb/argo/production.yaml
$ k apply -f infra/ingress-nginx/argo/production.yaml

# Vergeet niet ook in joriskt/homelab-k8s-infra te kijken voor storage drivers.
# Daarna installeren wat je wil! :)
```