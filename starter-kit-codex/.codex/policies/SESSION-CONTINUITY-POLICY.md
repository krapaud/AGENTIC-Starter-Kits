# Politique de continuité de session

## Principe

Une demande ponctuelle et un objectif persistant ne sont pas équivalents. Pour un travail multi-étapes, le Coordinateur doit utiliser le mécanisme d'objectif persistant de l'environnement lorsqu'il est disponible, par exemple `/goal`, avec une fin mesurable, les preuves attendues, les contraintes, le budget et la condition de blocage.

Cette politique ne prétend pas transformer une conversation ordinaire en boucle autonome. Si l'environnement ne fournit pas d'objectif ou de session persistante, l'agent conserve l'état local et indique clairement que la reprise nécessite un nouveau tour utilisateur.

## Contrat d'un objectif persistant

Avant activation, enregistrer dans `RUNTIME-STATE.md` :

- `goal_status: active | waiting | paused | complete | blocked | none` ;
- `goal_objective` : résultat attendu, formulé de façon vérifiable ;
- `goal_verification` : tests, fichiers, logs ou artefacts qui prouvent le résultat ;
- `goal_constraints` : limites à préserver ;
- `goal_budget` : limite de tours, temps ou tentatives ;
- `goal_blocked_condition` : décision ou accès qui justifie un arrêt ;
- `goal_session_id` si l'environnement en fournit un.

Un objectif actif n'autorise pas une clôture fondée sur une impression. La clôture exige les preuves du work item, l'état terminal local et la vérification du dernier tour. `idle` ou `turn completed` ne signifie pas que les outils ont tous réussi.

## Reprise et limites

L'agent peut reprendre automatiquement seulement si l'objectif est actif, que la session est idle, qu'aucune entrée utilisateur n'attend et qu'aucun travail n'est en cours. Un objectif en mode Plan ne doit pas déclencher de continuation d'implémentation. Une interruption volontaire, une limite de budget ou une décision humaine requise met l'objectif en pause ou en blocage et doit être journalisée. Une CI en cours, une intégration temporairement indisponible, une commande réessayable ou une reconnexion attendue sont des états `waiting`, jamais `blocked` et jamais une pause native du Goal. Le Coordinateur conserve `next_action`, enregistre un checkpoint `waiting` et reprend dès que la condition est résolue.

À chaque reprise : relire `RUNTIME-STATE.md`, le work item, les preuves et le dernier résultat de tour, puis exécuter `next_action`. Si l'environnement a malgré tout marqué le Goal natif `blocked` pour une attente récupérable, le Coordinateur doit d'abord réconcilier l'état local `waiting`, demander la reprise native uniquement si l'interface l'exige, puis exécuter `next_action` immédiatement. Ne jamais annoncer « je poursuis » sans lancer une action observable dans le même tour lorsque l'environnement le permet.

## Commandes d'environnement

Quand elles existent, utiliser les commandes natives de l'environnement : `/goal`, `/goal pause`, `/goal resume`, `/goal clear`. Ne pas inventer une commande équivalente et ne pas traiter un mode Agent ou Work locally comme une garantie de persistance.

## Activation automatique depuis Trello

Lorsqu'une demande explicite porte sur la finalisation d'une carte Trello et que sa checklist contient au moins deux éléments ouverts, le Coordinateur doit créer un objectif persistant avant de traiter la première case. L'objectif doit reprendre le titre de la carte, inclure toutes les cases ouvertes, la Definition of Done, les preuves attendues, les contraintes de branche/PR et la condition de blocage.

Le Coordinateur renseigne `goal_status: active`, `goal_objective`, `goal_verification`, `goal_constraints`, `goal_budget`, `goal_blocked_condition` et `goal_session_id` dans `RUNTIME-STATE.md`, puis active `/goal` ou l'API native lorsqu'elle est disponible. Une carte à une seule case, une demande d'information ou une tâche ponctuelle n'active pas automatiquement de Goal.

## Source de référence

Le comportement attendu est aligné sur la documentation officielle OpenAI sur les Goals et les sessions. Les URLs et la date de consultation doivent être conservées dans le work item ou l'ADR lorsque cette politique influence une décision.

## Runtime distribué

Si une session distante ou l'Agents API est utilisée, renseigner aussi les identifiants d'événements, d'éléments persistés, de tour, de trace et d'artefact dans `RUNTIME-STATE.md`. Après une coupure, récupérer la session et les éléments sauvegardés avant de reprendre. Ne jamais renvoyer une requête dont le `pending_request_id` ou le `pending_turn_id` est encore actif.

Traiter `required_action_type` avant toute reprise. Les valeurs attendues sont `none`, `function_call` ou `environment_connection`, avec un `required_action_status` résolu avant `complete`. Les événements webhook doivent être vérifiés cryptographiquement et dédupliqués par `webhook_event_id`.

Une clôture exige `budget_status` non épuisé, `environment_shutdown_status` sûr ou non requis, et un manifeste d'artefacts associant chaque livrable à son tour et à son empreinte. Les secrets, clés d'environnement, signatures webhook et données sensibles ne doivent jamais apparaître dans les logs, preuves, commits ou prompts.
