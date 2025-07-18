
Installing:

```bash
$ cd argocd/overlays/staging
$ k create ns argocd
$ k apply -k . -n argocd
```

Getting initial admin password:
```
$ argocd admin initial-password -n argocd
```

You should now be able to connect to [https://argo.staging.joris.me/](https://argo.staging.joris.me/).

Now configure ArgoCD to manage itself:
```
$ k apply -f argocd/argo/staging.yaml
```

You should see the `argocd` application appear in the ArgoCD UI.
