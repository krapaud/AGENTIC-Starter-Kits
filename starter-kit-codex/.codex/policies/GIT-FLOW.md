# Git Flow universel

## Branches obligatoires

La branche d intégration est définie dans `project-profile.toml`, habituellement `develop`. Toute modification produit commence sur une branche dédiée : `feature/<id>-<sujet>`, `fix/<id>-<sujet>`, `hotfix/<id>-<sujet>`, `chore/<id>-<sujet>`, `docs/<id>-<sujet>`, `refactor/<id>-<sujet>` ou `test/<id>-<sujet>`.

Ne jamais développer, committer ou pousser directement vers `main`, `master` ou la branche d intégration. La promotion vers ces branches passe par une Pull Request validée. Une branche ne porte qu un objectif cohérent et un seul work item actif.

## Commits atomiques

Un commit correspond à une intention vérifiable : une étape de conception, une migration, une modification fonctionnelle, des tests, une documentation liée ou une correction ciblée. Il contient le minimum de fichiers nécessaire, un message `type(scope): description` et des contrôles adaptés.

Les limites par défaut sont `75` fichiers et `1200` lignes modifiées par commit. Elles sont configurables dans `[delivery]` de `project-profile.toml` seulement après décision explicite et documentée. Un commit massif de code métier est interdit. Un lockfile ou artefact généré incompressible peut dépasser la limite uniquement dans un commit séparé, sans code métier, avec un message conventionnel et une justification dans le work item. L agent isole automatiquement ce commit et ne demande pas une autorisation pour une limite technique connue.

## Promotion

Une branche ne passe vers l intégration qu avec work item, conception à jour, tests proportionnés, preflight vert, preuves, audit indépendant et rapport sécurité lorsque la matrice l exige. `main` reçoit seulement des livraisons validées. Ne pas réécrire l historique des branches protégées.

## Contrôle de périmètre avant livraison

Avant tout commit final ou toute Pull Request, le Coordinateur compare le diff complet depuis la branche d intégration au résultat attendu, au hors périmètre et aux fichiers autorisés du work item. Il exécute au minimum `git diff --name-status <branche-intégration>...HEAD`, relit chaque commit et classe chaque fichier : `autorisé`, `preuve nécessaire`, `hors périmètre` ou `généré`. Un fichier hors périmètre bloque la livraison. Il ne doit pas être supprimé ou masqué pour obtenir un diff vert.

Si la branche contient plusieurs objectifs, un changement de maintenance, de configuration ou d’internationalisation sans lien direct, ou plusieurs work items, le Coordinateur bloque la PR et crée une branche propre depuis la branche d’intégration. Il reporte uniquement les commits pertinents, vérifie le diff de la nouvelle branche et conserve l’ancienne branche comme archive jusqu’à décision de l’utilisateur. Une PR ne doit jamais mélanger des domaines simplement parce que les tests passent.

## Contrôle automatisé

`verify-before-push.sh` bloque le push direct vers une branche protégée, les noms de branche non conformes et les commits dépassant les limites déclarées. Ne jamais contourner ce contrôle avec `--no-verify`.

Le contrôle de livraison doit également échouer si le work item, la branche, le titre de PR et le diff ne décrivent pas le même objectif. Les changements non rattachés reçoivent leur propre work item et leur propre branche avant toute promotion.

## État inconnu

Si Git est indisponible, le Coordinateur peut préparer le travail et les preuves locales, mais ne doit pas prétendre avoir créé une branche, une Pull Request ou une fusion.

## Pull Requests automatiques

Toute Pull Request créée automatiquement par le starter kit cible exclusivement `develop` ou `dev`. Le workflow refuse toute autre branche cible, notamment `main`. Une promotion vers `main` doit être réalisée par un humain ou demandée explicitement par l’utilisateur dans la conversation, avec une justification et des contrôles verts.

## Pull Request par carte

Une carte Trello correspond par défaut à une branche de travail et à une seule Pull Request finale. Les commits restent atomiques et peuvent couvrir plusieurs étapes de la checklist, mais l'agent ne crée pas de PR pour chaque contrôle, sous-tâche, correction ou document. Si une PR existe déjà pour la carte, il la met à jour jusqu'à la Definition of Done. Une PR intermédiaire exige une demande explicite de l'utilisateur ou une justification critique documentée.
