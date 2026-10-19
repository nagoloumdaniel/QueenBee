# infra/k3s — manifests Kubernetes optionnels (passerelles >= 2 Go RAM)

**Rôle** : variante K3s du déploiement de site. Par défaut, les passerelles utilisent **Docker Compose** (`../compose/site.yml`) car K3s consomme ~500 Mo au repos (ROADMAP §1). On n'utilise K3s que si la passerelle a >= 2 Go de RAM. Les **mêmes images** servent dans les deux modes.

## Contenu attendu (`manifests/`)

Vide pour l'instant (`.gitkeep`). À remplir **seulement si** le choix K3s est retenu (ADR) :
`Namespace`, `StatefulSet` Mosquitto + `PersistentVolumeClaim` (cache disque), `Deployment` edge-acoustic, `ConfigMap` (site.conf), `Secret` (références, jamais de valeurs).

## Lancer (si utilisé)

```bash
kubectl apply --dry-run=client -f manifests/   # validation locale
kubectl apply -f manifests/                    # sur la passerelle, via Ansible (rôle site)
```

## Epics

- **EP-05 [EDGE]** : décision Compose vs K3s (ADR), manifests le cas échéant.

## Bonnes pratiques locales

- Ne pas dupliquer la logique : la config Mosquitto vient de `../mosquitto/site.conf`.
- Aucun secret dans les manifests ; limites CPU/mémoire obligatoires sur les petites passerelles.
