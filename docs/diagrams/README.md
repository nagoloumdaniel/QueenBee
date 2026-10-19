# docs/diagrams

Diagrammes **Mermaid versionnés avec le code** (ROADMAP §4.8 et §4.9). GitHub les affiche directement.

| Fichier | Question à laquelle il répond | Type |
|---|---|---|
| `context.md` | Qui parle à qui ? Quels sont les grands blocs (central, sites, capteurs, simulateur) ? | flowchart |
| `ingest-sequence.md` | Que se passe-t-il quand un capteur envoie une mesure (UC-T02) ? | séquence |
| `sync-sequence.md` | Comment une inspection saisie hors ligne arrive-t-elle sur le serveur (UC-A01) ? | séquence |
| `alert-states.md` | Quels sont les états possibles d'une alerte et les transitions ? | états |
| `deployment.md` | Comment le code arrive-t-il en production (CI -> registre -> central et sites) ? | flowchart |
| `er.md` | Quelles sont les tables et leurs relations (MCD) ? | ER |

## Règles (PLAYBOOK §7 MODEL)
- **Un diagramme = une question** ; titre + légende + source en tête du fichier.
- Lisible sans l'auteur : noms de participants explicites, pas d'abréviation inconnue.
- Mise à jour dans la **même PR** que le code qui change le comportement décrit.
- Diagrammes encore à produire (backlog MODEL) : cas d'utilisation, composants, activité/BPMN de la déclaration de récolte, états d'une inspection, pipeline CI/CD (voir ROADMAP §5.3).
- Export en image pour le dossier : copier le Mermaid dans Draw.io ou utiliser `mmdc` (Mermaid CLI), puis référencer l'annexe.
- Sécurité : ne jamais mettre de secret, d'IP réelle ni de nom d'hôte interne dans un diagramme.
