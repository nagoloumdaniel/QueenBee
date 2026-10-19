# Annexes - Bloc 2

> Les annexes sont numérotées **A1, A2...**, titrées, **citées au moins une fois dans le texte**, et contiennent une **preuve** (code, configuration, journal, capture, rapport, compte rendu) accompagnée d'**une ligne indiquant ce qu'elle démontre**. Elles ne comptent pas dans le volume.

## Index des annexes
| N° | Intitulé | Ce qu'elle démontre | Partie de renvoi |
|----|----------|---------------------|------------------|
| A1 | Exigences et contraintes issues du cahier des charges | Architecture déduite des exigences | 2 |
| A2 | Comparaison des options d'architecture | Options réellement comparées | 2 |
| A3 | Diagrammes (composants, déploiement, séquence) | Modélisation normalisée lisible sans l'auteur | 2 |
| A4 | Journal des décisions d'architecture (ADR) | Raison des choix et des options écartées | 2 |
| A5 | Matrice cas d'utilisation / composants, prototype | Couverture des scénarios | 2 |
| A6 | Règles de contribution, listes de contrôle, extrait de revue de code | Règles réellement appliquées | 3 |
| A7 | Rapport d'analyse statique et de contrôle des dépendances | Sécurité shift-left | 3 |
| A8 | Maquettes, captures, extraits de composant | Interface réalisée | 4 |
| A9 | Rapport d'audit d'accessibilité, tests utilisateurs | Accessibilité démontrée | 4 |
| A10 | Contrat d'interface (OpenAPI), schéma de base de données | Liaison front/back documentée | 5 |
| A11 | Rapport de tests de sécurité, mesures de performance | Sécurité vérifiée par des tests | 5 |
| A12 | Schéma des flux, extraits de la chaîne de données, mesures de volume et délai | Dimensionnement démontré | 6 |
| A13 | Mesures d'éco-conception (CPU/RAM/octets) | Impact estimé et arbitrage | 7 |

## Règles
- Un fichier (ou sous-dossier) par annexe dans ce dossier : `A1-<slug>.md` (ou `.pdf`, `.png` pour une capture/rapport).
- Anonymiser (noms, e-mails, identifiants, adresses IP) ; **aucun secret** ni jeton.
- Les commandes, configurations et journaux complets vont ici, pas dans le corps du texte.
- Mettre l'index à jour à chaque nouvelle annexe ; vérifier à la fin que chaque annexe est citée.
