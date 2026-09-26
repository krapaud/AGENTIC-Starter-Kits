# Skill coordination

## Objectif

Transformer une demande en livraison vérifiable, avec un seul responsable du plan et des dépendances explicites.

## Quand l'utiliser

Pour toute demande qui modifie le produit, ses documents, sa configuration ou sa livraison. Ne pas l'utiliser pour une question purement explicative sans changement attendu.

## Entrées requises

Demande, critères d'acceptation, `.codex/project-profile.toml`, état Git si disponible, fichiers concernés et contraintes déclarées.

## Récupération et recherche

Ne pas transmettre une erreur corrigeable à l’utilisateur comme conclusion. Déclencher le diagnostic, la recherche documentaire ou internet, la correction et la validation. Continuer jusqu’à réussite, limite documentée ou blocage réel. Ne pas attendre un message « Continue », « approuve » ou une validation intermédiaire lorsque la prochaine étape est déjà autorisée. Poursuivre les tâches indépendantes malgré une limite locale, en la documentant.

## Procédure

1. Créer un work item avec résultat, hors périmètre, critères et budget.
2. En mode `autonomous-after-brief` et lorsque `execution_authorization = "continuous-until-done"`, une instruction comme « fais tout » autorise l’exécution de toutes les sous-tâches du work item jusqu’à la Definition of Done. Regrouper les choix non bloquants en décisions réversibles dans un ADR et continuer sans interrompre l’utilisateur. Ne poser qu’une demande consolidée pour les blocages réels.
3. Évaluer le risque avec `.codex/RISK-MATRIX.md`.
4. Décomposer le résultat en tâches atomiques qui indiquent rôle, Skill, dépendances, fichiers autorisés et preuves.
5. Ne paralléliser que les tâches sans contrat ni fichier commun.
6. Transmettre le contexte minimal utile, jamais le dépôt entier par défaut.
7. Collecter les rapports, preuves et risques résiduels.
8. Demander l'audit requis, puis clôturer ou faire reprendre le travail.

## Sélection de la prochaine carte

Pour une autorisation `continuous-until-done` portant sur un lot Trello, le Coordinateur ne s'arrête pas après la clôture d'une carte. Il relit le tableau, filtre les cartes `Ready` ou reprenables sans dépendance ouverte, échéance bloquante ou blocage documenté, puis démarre immédiatement la première carte éligible. Il met à jour l'état runtime et lance une action observable dans le même tour. Une demande explicitement limitée à une carte reste limitée à cette carte.

## Boucle d.optimisation du Coordinateur

Avant chaque délégation, lire les métriques disponibles et les évaluations comparables. Le registre est interne et ne doit jamais interrompre un work item autorisé. Réduire le contexte, réutiliser les résultats validés, regrouper les tâches indépendantes, puis router Luna pour les tâches répétitives à faible risque, Terra pour l.implementation et les audits courants, et Sol pour les décisions complexes ou critiques. Après chaque work item, comparer qualité, défauts, durée, contexte, relances et coût estimé. En cas de dérive, modifier un seul paramètre et vérifier la non-régression.

## Contrôles

Chaque tâche doit avoir un propriétaire, un risque, un périmètre, une règle d'arrêt et une preuve attendue. Toute dérive de budget, de portée ou de sécurité impose une escalade.

## Sortie

Plan de travail, état des dépendances, décision de clôture et évaluation enregistrée.

## Mesures

Tours, contexte transmis, relances, durée, défauts après audit et tâches reprises.

## Arrêt

Arrêter si le besoin devient ambigu, si une décision métier ou irréversible est nécessaire, si le budget est dépassé ou si une dépendance externe manque.
