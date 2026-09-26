# Validation avant push

## Règle absolue

Avant chaque `git push` vers GitHub, l'agent responsable exécute `bash .claude/scripts/verify-before-push.sh`. Un échec interdit le push. `git push --no-verify` est interdit.

## Contrôles exigés

Le contrôle exécute le preflight, le socle cybersécurité, lint, les tests déclarés, le build déclaré et la vérification du diff. Lorsqu'un projet active `frontend` ou `backend`, les commandes `commands.lint` et `commands.test` sont obligatoires dans le profil technique.

Il vérifie aussi le périmètre de la branche depuis la branche d'intégration. Le diff est comparé au résultat attendu, au hors périmètre et aux fichiers autorisés du work item. Toute modification non rattachée au work item bloque le push de livraison, même si lint et tests passent. Pour corriger une branche mélangée, créer une branche propre depuis `dev` ou `develop`, reporter uniquement les commits liés au work item, puis relancer toute la validation.

## Responsabilités

L'agent qui modifie le code exécute les contrôles et fournit les résultats. L'Auditeur vérifie les preuves avant fusion lorsque la matrice de risque l'exige. Aucun agent ne présente un contrôle non exécuté comme réussi.

## Hook local

`init-project.sh` installe le hook `pre-push` quand Git est disponible. Le hook relance la validation et bloque l'envoi local en cas d'échec.
