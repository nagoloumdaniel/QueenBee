# Déploiement

**Question** : comment le code passe-t-il de GitHub aux serveurs centraux et aux 8 sites ?
**Source** : ROADMAP §4.8 (« Déploiement »). Pipeline détaillé : ROADMAP §5.3. Chaque déploiement écrit dans la table `deployment` (KPI > 95 % de réussite).

```mermaid
flowchart TB
  GH[GitHub Actions] -->|build+test+Snyk| REG[GHCR]
  REG -->|Ansible pull| CEN[VM Oracle - Docker Compose central]
  REG -->|Ansible via VPN| S1[Site pilote - Compose/K3s]
  REG --> S2[Sites 2..8]
  CEN --- MON[Prometheus/Grafana/Loki]
  S1 -. métriques .-> MON
```
