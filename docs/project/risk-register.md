# Registre des risques

> Source : ROADMAP §4.1 (matrice probabilité x impact, échelle 4x4, score = probabilité x impact). **À réviser à chaque fin de sprint** et à citer dans le Bloc 1 (parties 2, 6 et 7). Un risque qui se réalise est copié dans `deviation-journal.md`.

## Échelle
| Niveau | Probabilité | Impact |
|---|---|---|
| 1 | Rare | Mineur (gêne, sans retard) |
| 2 | Possible | Modéré (retard < 1 semaine) |
| 3 | Probable | Important (retard > 1 semaine ou fonction dégradée) |
| 4 | Quasi certain | Critique (livrable ou compétence compromis) |

Seuil d'action : score >= 9 = plan de réduction obligatoire et suivi à chaque sprint ; score >= 12 = traité en priorité.

## Registre (état initial, ROADMAP §4.1)
| ID | Risque | Proba | Impact | Score | Mesure | Propriétaire | Statut | Dernière révision |
|---|---|---|---|---|---|---|---|---|
| R1 | Simulateur en retard bloque Data/Cyber | 3 | 4 | 12 | Version minimale S2, enrichie ensuite | (à assigner) | Ouvert | |
| R2 | Échec déploiement site isolé | 3 | 4 | 12 | Pilote d'abord + rollback testé | (à assigner) | Ouvert | |
| R3 | Passerelle trop faible pour K3s | 3 | 3 | 9 | Mode Compose | (à assigner) | Ouvert | |
| R4 | Compétence front-end hors périmètre DevOps | 2 | 3 | 6 | Accord tuteur S2 | (à assigner) | Ouvert | |
| R5 | Équipe peu disponible | 3 | 3 | 9 | Capacité réelle chiffrée S1 | (à assigner) | Ouvert | |
| R6 | Fuite de données bénéficiaires | 2 | 4 | 8 | Chiffrement, RBAC, minimisation | (à assigner) | Ouvert | |
| R7 | Conflits de sync hors-ligne | 3 | 3 | 9 | Stratégie de résolution + tests | (à assigner) | Ouvert | |
| R8 | Ressources VM limitées (14 Go) | 2 | 3 | 6 | Dimensionnement frugal | (à assigner) | Ouvert | |

## Matrice (positions initiales)
| Proba \ Impact | 1 | 2 | 3 | 4 |
|---|---|---|---|---|
| 4 | | | | |
| 3 | | | R3, R5, R7 | R1, R2 |
| 2 | | | R4, R8 | R6 |
| 1 | | | | |

## Risques complémentaires à scorer en S01
Identifiés dans le cahier des charges (Partie C.6) mais **non chiffrés** : à discuter en équipe puis à ajouter au tableau ci-dessus (ne pas inventer de score).
| ID provisoire | Risque | Pourquoi c'est important | Piste de mesure |
|---|---|---|---|
| R9 | Surcoût du calcul acoustique en edge non mesuré | Cité comme limite dans le gabarit | Mesurer CPU/RAM/énergie sur la passerelle, en faire un indicateur |
| R10 | Sécurité de la chaîne CI/CD | Snyk est une porte obligatoire | Faire échouer le pipeline sur vulnérabilité critique, garder le rapport en annexe |
| R11 | Délais de remise des dossiers | Remise 2 à 4 semaines avant la soutenance | Rétro-planifier la rédaction dans le calendrier |
| R12 | Écart plan / réalité non documenté | Le Bloc 1 exige des écarts réels | Tenir `deviation-journal.md` dès S01 |
| R13 | Connectivité intermittente | Cache, déduplication, reprise critiques | Tests de coupure chronométrés avec le simulateur |

## Historique des révisions
| Date | Sprint | Changements (nouveaux risques, scores modifiés, risques clos) | Auteur |
|---|---|---|---|
| | | | |
