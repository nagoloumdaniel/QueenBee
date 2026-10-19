# Checklist d'éco-conception / numérique responsable

> Exigences du ROADMAP §4.6, à vérifier à chaque PR concernée et à mesurer avant la fin du projet (preuves pour le Bloc 1 Ce1.3.4, Bloc 2 Ce2.1.6 / Ce2.4.6 et la compétence transversale « numérique responsable »). Principe : **mesurer avant/après** et **arbitrer performance vs sobriété** par écrit.

## Exigences
| # | Exigence | Cible / mesure | Statut |
|---|---|---|---|
| E1 | Acoustique traitée en edge : seul un vecteur de features (~8 octets) part en radio, **jamais l'audio brut** | octets/trame mesurés | [ ] |
| E2 | Échantillonnage adaptatif des capteurs | fréquence moyenne vs fixe (15 min) | [ ] |
| E3 | Compression + rétention TimescaleDB | taille avant/après compression ; rétention 3 ans | [ ] |
| E4 | Images en WebP, redimensionnées côté mobile avant envoi | poids moyen par photo | [ ] |
| E5 | Pagination par curseur et cache HTTP (ETag) | taux de 304 ; taille de réponse | [ ] |
| E6 | Conteneurs minimaux (distroless/alpine), un processus par conteneur | taille des images (Trivy) | [ ] |
| E7 | Arrêt automatique des VM de test hors séance | planning d'arrêt (Terraform/Ansible) | [ ] |
| E8 | Mesure CPU / RAM / énergie par service | cAdvisor + Grafana, relevé par service | [ ] |
| E9 | Budget de poids de la landing | **<= 200 Ko de JS**, LCP <= 2,5 s, INP <= 200 ms, CLS <= 0,1 | [ ] |
| E10 | App mobile légère | **APK < 30 Mo** | [ ] |
| E11 | Sync économe | une journée (38 400 mesures) en < 2 min, lots compressés | [ ] |
| E12 | Pas de redondance inutile ; composants stricts nécessaires | revue d'architecture (ADR) | [ ] |

## Bonnes pratiques de code
- [ ] Requêtes SQL avec index justifié par la requête ; pas de N+1 ; agrégats continus plutôt que recalcul.
- [ ] Pas de polling inutile (push/MQTT/événements) ; backoff exponentiel en cas d'échec.
- [ ] Web : Server Components par défaut, `next/image`, polices auto-hébergées (`next/font`), imports dynamiques pour les cartes/graphiques.
- [ ] Mobile : widgets `const`, listes paginées/paresseuses, pas de travail lourd sur le thread UI.
- [ ] Logs structurés et **bornés** (rotation, niveau adapté) ; pas de métriques à cardinalité explosive.
- [ ] Environnements éphémères détruits après usage ; pas de VM allumée « au cas où ».

## Estimation de l'impact (à compléter)
| Poste | Hypothèse | Estimation | Source / mesure |
|---|---|---|---|
| Hébergement central (VM 14 Go) | heures/mois, puissance | ... | ... |
| Passerelles de site (8) | puissance, solaire | ... | ... |
| Trafic réseau | octets/jour (38 400 mesures ~ 10 Mo/jour) | ... | ... |
| Poids des pages / de l'APK | Ko | ... | Lighthouse, `flutter build` |
| Environnements CI | minutes/mois | ... | GitHub Actions |

## Arbitrages performance / sobriété (à documenter)
| Décision | Gain de sobriété | Coût en performance | Choix |
|---|---|---|---|
| Ex. calcul acoustique sur la passerelle | trafic radio et énergie réduits | surcoût CPU non mesuré à ce jour | à mesurer |
