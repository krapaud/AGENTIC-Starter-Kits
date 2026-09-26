# Orchestration Claude portable

## Objectif

Ce répertoire s'importe dans tout nouveau projet. Il adapte les contrôles à partir de `project-profile.toml` sans imposer de langage, framework, outil de suivi ou fournisseur de déploiement. Lire aussi `CONVERSATION-MODES.md`, `PROJECT-CONTEXT.md`, `PROJECT-DATA-BOUNDARY.md`, `FILE-MANIFEST.md`, `models.toml`, `MODEL-POLICY.md`, `GOVERNANCE.md`, `RISK-MATRIX.md`, `COST-AND-EVALUATION.md` et `ADAPTERS.md`.

## Recherche actualisée

Lire et appliquer obligatoirement `policies/WEB-RESEARCH-POLICY.md`, `policies/SESSION-CONTINUITY-POLICY.md`, `policies/EXCEPTIONAL-REQUESTS.md`, `policies/TRELLO-VISUAL-SYSTEM.md`, `policies/TRELLO-START-STATE.md` et `policies/DOCUMENTATION-LANGUAGE-POLICY.md`. Le Coordinateur déclenche une recherche externe dès qu'une information peut avoir changé ou engage une décision technique, légale, de sécurité, de coût ou de compatibilité. Les agents concernés consignent les sources et la date de consultation dans les preuves.

## Cycle obligatoire

1. Recevoir et accepter le cahier des charges.
2. Poser une seule série de questions de complétude avec choix recommandés.
3. Mettre à jour `RUNTIME-STATE.md` à chaque transition et après chaque erreur.
4. Recevoir le choix Trello et initialiser le profil du projet.
5. Créer un work item.
6. Classer toute demande exceptionnelle et créer une carte Trello dès que le seuil S3 ou S4 est atteint.
7. Choisir rôle et Skill.
8. Implémenter dans le périmètre déclaré.
9. Auditer, vérifier et enregistrer les preuves.
10. Livrer, évaluer et archiver.

## Règles

- Claude est l'unique orchestrateur.
- Le profil du projet est la source de vérité des technologies, commandes et conventions locales.
- Une tâche active par flux, sauf tâches indépendantes sans fichiers communs.
- Le niveau de risque commande la profondeur de revue.
- Les intégrations GitHub, Trello, Docker et autres sont facultatives.
- Les fichiers de produit restent hors de `.claude/`.
- Lire `SPECIALIST-AGENTS.md` avant toute délégation. Le Coordinateur compare le besoin aux conditions d’activation, met à jour `[agents]`, justifie chaque activation dans le work item et exige les livrables annoncés.
- Un spécialiste désactivé ne doit pas être appelé. Les agents de QA, Cybersécurité, Accessibilité et Auditeur contrôlent la livraison lorsqu’ils sont requis par le risque ou la nature du produit.

## Autorisation continue

Lorsque l’utilisateur demande de tout faire ou de poursuivre jusqu’à la livraison, exécuter la chaîne complète du work item sans interruption volontaire. Produire des checkpoints et rapports intermédiaires sans demander d’approbation. Arrêter uniquement pour un blocage sensible défini par la politique d’autonomie.

Lorsqu'une carte Trello à terminer possède au moins deux cases ouvertes, activer le Goal persistant décrit dans `policies/SESSION-CONTINUITY-POLICY.md` avant la première case et rattacher toutes les preuves au même objectif.

## Reprise automatique

À chaque nouvelle session, lire `RUNTIME-STATE.md`, le dernier work item, le dernier commit et les rapports avant de demander quoi que ce soit. Reprendre directement l’action autorisée.

## Rapport exigé

```text
Statut: complete | blocked | needs-review
Perimetre: fichiers et limites
Travail: résumé factuel
Preuves: commandes et résultats
Risques: inconnues restantes
Suite: action recommandée
Sources: URLs consultées et décisions influencées
```

Lire et appliquer obligatoirement `.codex/policies/TASK-ROUTING-POLICY.md` ou `.claude/policies/TASK-ROUTING-POLICY.md` avant toute délégation, y compris pour une demande hors cahier des charges initial.

## Synchronisation après chaque livraison

Après chaque étape validée, fusion, correction ou changement de statut, relire la carte Trello concernée et sa checklist. Une livraison sans mise à jour et preuve de relecture Trello est incomplète.

Lire et appliquer obligatoirement la politique DELIVERY-CLOSURE-POLICY.md avant de suspendre, clôturer ou déclarer bloqué un work item.
