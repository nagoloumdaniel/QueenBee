# Checklist d'accessibilité - WCAG 2.2 AA / RGAA 4.1

> À cocher dans **chaque PR qui touche à l'interface** (DoD, `docs/jira/PLAYBOOK.md` §6). Un outil automatique (axe-core) n'est qu'un point de départ : il faut aussi un test manuel (clavier, TalkBack/VoiceOver). Les résultats alimentent l'audit en annexe du dossier (Bloc 2, C2.3 ; Bloc 1, Ce1.3.3).

Exigences chiffrées du projet (ROADMAP §4.5) : contraste >= 4,5:1 · cibles tactiles >= 48 dp · navigation clavier complète (web) · lecteurs d'écran (TalkBack/VoiceOver) · `prefers-reduced-motion` · textes simples en français · icônes + texte · saisie minimale.

## Commune (web et mobile)
- [ ] Contraste texte/fond >= 4,5:1 (3:1 pour grand texte et éléments graphiques) - mode clair ET sombre.
- [ ] L'information n'est **jamais** portée par la couleur seule (icône + texte pour gravité, statut).
- [ ] Textes courts, vocabulaire simple, une action principale par écran, pictogramme + mot.
- [ ] Messages d'erreur clairs, associés au champ, avec la manière de corriger ; pas de limite de temps non prolongeable.
- [ ] Chaque écran dessine les états **loading / erreur / vide / hors-ligne**, annoncés aux technologies d'assistance.
- [ ] Mouvement réduit respecté (`prefers-reduced-motion` / `MediaQuery.disableAnimations`) ; pas de clignotement.
- [ ] Texte agrandissable jusqu'à 200 % sans perte de contenu ni de fonction.
- [ ] Langue déclarée (`lang="fr"` / locale) ; i18n prêt pour les langues locales.
- [ ] Authentification accessible (pas de test cognitif bloquant, collage de mot de passe autorisé, WCAG 2.2 - 3.3.8).

## Web (Next.js)
- [ ] Un seul `<h1>`, hiérarchie des titres logique ; repères (`header`, `nav`, `main`, `footer`) ; lien d'évitement vers `#contenu`.
- [ ] **Navigation 100 % clavier** : ordre logique, aucun piège, focus **toujours visible** (WCAG 2.4.7, 2.4.11), cibles >= 24x24 px minimum (objectif 48).
- [ ] Formulaires : `<label>` associé à chaque champ, `autocomplete`, erreurs liées par `aria-describedby`, `aria-invalid`.
- [ ] Composants dynamiques (dialogue, menu, tableau trié) : rôle/état ARIA corrects (Radix), focus piégé/restitué, Échap ferme.
- [ ] Tableaux de données : `<caption>`, `scope`, tri annoncé (`aria-sort`).
- [ ] Graphiques et cartes : alternative textuelle ou tableau équivalent ; carte doublée d'une liste.
- [ ] Images : `alt` pertinent (ou `alt=""` si décoratif) ; pas de texte dans les images.
- [ ] Responsive de 320 px à desktop, sans défilement horizontal (reflow 1.4.10).
- [ ] **axe-core : 0 violation critique** dans les tests E2E (`tests/e2e/*.spec.ts`).

## Mobile (Flutter)
- [ ] Cibles tactiles >= **48 dp** (`androidTapTargetGuideline`, `iOSTapTargetGuideline`).
- [ ] `Semantics` (label, hint, rôle) sur tout élément interactif non standard et sur les icônes porteuses de sens ; `ExcludeSemantics` sur le décoratif.
- [ ] Zones dynamiques annoncées (`liveRegion`) : bannière hors-ligne, erreurs, compteur de sync.
- [ ] Ordre de focus/lecture logique (`FocusTraversalGroup`, `sortKey`).
- [ ] Test manuel **TalkBack** (Android) et **VoiceOver** (iOS) sur les parcours UC-A01 à A03.
- [ ] Taille de police système respectée (`MediaQuery.textScaler`) sans troncature bloquante.
- [ ] Saisie minimale : choix à pictogrammes + mots, clavier adapté (`numeric`, `email`), pas de saisie libre superflue.
- [ ] QR code : alternative de saisie manuelle du code de la ruche.

## Preuves à conserver
| Preuve | Outil | Où la ranger |
|---|---|---|
| Rapport axe-core par page | `@axe-core/playwright` | artefacts CI |
| Rapport TalkBack / VoiceOver (parcours, observations) | test manuel | `docs/dossier/bloc2/annexes/` |
| Mesures de contraste | outil de contraste | `docs/dossier/bloc2/annexes/` |
| Capture avant/après des corrections | - | annexe audit |
