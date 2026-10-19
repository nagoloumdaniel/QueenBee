# docs

Documentation du projet QueenBee, versionnée avec le code.

| Dossier / fichier | Contenu |
|---|---|
| `adr/` | Décisions d'architecture (une décision = un ADR daté) |
| `diagrams/` | Diagrammes Mermaid : contexte, séquences, états, déploiement, ER |
| `runbooks/` | Procédures d'exploitation (une alerte = un runbook) |
| `openapi.yaml` | Contrat d'API (OpenAPI 3.1), source des types web/mobile |
| `data-dictionary.md` | Dictionnaire de données (généré depuis le DDL) |
| `accessibility/` | Checklist WCAG 2.2 AA / RGAA 4.1 |
| `eco-conception/` | Checklist numérique responsable + mesures |
| `security/` | Checklist OWASP ASVS niveau 2 |
| `compliance/` | Registre RGPD, grille de conformité RGPD / ITIL / ANSSI |
| `project/` | Pilotage : registre des risques, journaux de décisions et d'écarts, comptes rendus de sprint, veille |
| `dossier/` | Matière des dossiers professionnels Bloc 1 et Bloc 2 |
| `jira/` | Playbook et tickets (géré à part) |

Règle : toute PR qui change un comportement met à jour la doc concernée (Definition of Done, `docs/jira/PLAYBOOK.md` §6).
