- Secret maken met de hand
```bash
$ k create secret generic <name> --dry-run=client --from-file=/dev/stdin -o yaml > secret.yaml
```

- Secret converteren naar SealedSecret
```bash
$ kubeseal -f secret.yaml -o sealedsecret.yaml
```

Het bestand `sealedsecret.yaml` is nu veilig te gebruiken.