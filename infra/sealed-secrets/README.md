- Secret maken met de hand
```bash
$ k create secret generic <name> --dry-run=client --from-file=/dev/stdin -o yaml > secret.yaml
```

- Secret converteren naar SealedSecret
```bash
$ kubeseal --controller-namespace sealed-secrets -n <namespace> -f secret.yaml -o yaml > sealedsecret.yaml
```

Het bestand `sealedsecret.yaml` is nu veilig te gebruiken.

**Verwijder `secret.yaml` voordat je hem verwijdert.**
