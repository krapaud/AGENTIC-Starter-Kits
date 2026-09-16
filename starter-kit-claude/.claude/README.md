# Kit d'orchestration Claude Code portable

Ce kit installe une gouvernance projet native pour Claude Code. Il ne construit rien tant que le cahier des charges n'a pas été fourni et formalisé.

## Prérequis

- Claude Code est installé.
- Le projet possède une racine dédiée. Un dépôt Git est recommandé, mais l'initialisation fonctionne avant `git init`.
- Le cahier des charges est prêt ou peut être envoyé dans le chat au premier échange.

## Installation pas à pas

1. Ouvrir un terminal dans le nouveau projet.

2. Définir le chemin du kit source :

```bash
KIT_SOURCE="/chemin/vers/agentic-starter-kits/starter-kit-claude"
```

3. Copier le point d'entrée obligatoire et toute la configuration :

```bash
cp "$KIT_SOURCE/CLAUDE.md" .
cp -R "$KIT_SOURCE/.claude" .
```

4. Lancer l'initialisation non destructive :

```bash
bash .claude/scripts/init-project.sh
```

Cette commande crée `project-profile.toml` s'il est absent et génère un inventaire des fichiers détectés. Elle ne modifie pas le code du produit.

5. Démarrer une nouvelle session Claude Code à la racine du projet :

```bash
claude
```

Une nouvelle session est importante car les sous-agents de `.claude/agents/` sont chargés à son démarrage.

6. Envoyer une demande projet normale, par exemple :

```text
Je veux construire une application de réservation pour des associations locales.
```

7. Claude doit répondre uniquement par une demande de cahier des charges. Envoyer alors le cahier dans le chat. Il peut être rédigé naturellement, mais doit préciser le besoin, les utilisateurs, le périmètre, les contraintes, les critères de réussite et le hors périmètre.

8. Après acceptation, Claude remplit `.claude/PROJECT-BRIEF.md`, applique le Skill `project-onboarding` et complète `.claude/project-profile.toml` avec les technologies réellement présentes ou validées.

9. Vérifier que le projet est prêt :

```bash
bash .claude/scripts/preflight.sh
```

`Preflight OK` confirme que le cahier est accepté, que le profil est complet et que les contrôles structurels du kit passent.

## Utilisation quotidienne

Après l'onboarding, décrire une tâche avec son résultat attendu et ses critères d'acceptation. Le Coordinateur attribue ensuite les rôles, demande des preuves et impose l'audit avant clôture.

Pour ne pas déclencher la porte projet dans une conversation générale, commencer le message par :

```text
Mode général : explique-moi la différence entre REST et GraphQL.
```

Pour entretenir le kit sans démarrer le produit :

```text
Mode maintenance : vérifie les Skills du kit.
```

## Arborescence importée

```text
CLAUDE.md                         Instructions permanentes chargées par Claude Code
.claude/agents/                   Sous-agents Markdown avec frontmatter YAML
.claude/skills/                   Skills natifs, un dossier par SKILL.md
.claude/project-profile.toml      Technologies et commandes du projet
.claude/PROJECT-BRIEF.md          Cahier des charges formalisé après réception
.claude/policies/                 Qualité, Gitflow, incidents et validation
.claude/scripts/                  Initialisation et contrôles internes
.claude/work-items/               Tâches suivies et archives
.claude/decisions/                Décisions traçables
.claude/metrics/                  Mesures coût et qualité
.claude/reports/                  Rapports d'audit et de livraison
```

Les dossiers initialement vides contiennent un `.gitkeep`, afin qu'ils restent présents dans Git après import ou clonage.

## À ne pas faire

- Ne pas importer le kit Codex dans le même projet.
- Ne pas modifier `PROJECT-BRIEF.md` pour simuler son acceptation sans cahier réel.
- Ne pas lancer le preflight avant l'onboarding en attendant un succès : son blocage est intentionnel.
- Ne pas copier une CI générique sans adapter les commandes à `project-profile.toml`.

## Validation avant GitHub

`init-project.sh` installe un hook Git pre-push lorsque le projet est un dépôt. Avant chaque push, le rôle responsable exécute :

```bash
bash .claude/scripts/verify-before-push.sh
```

Le contrôle lance le preflight, le socle cybersécurité et les commandes configurées dans `project-profile.toml`. Pour un projet frontend ou backend, les commandes `lint` et `test` sont obligatoires. Un échec bloque le push. Ne jamais utiliser `--no-verify`.

Après onboarding, générer si nécessaire le workflow GitHub Actions du projet :

```bash
bash .claude/scripts/generate-github-ci.sh
```

Le générateur refuse de remplacer un workflow existant. Relire le fichier produit, définir les secrets dans GitHub et garder tout déploiement soumis aux validations décrites dans les politiques.

## Compatibilité machine

macOS et Linux : utiliser Bash avec Git, ripgrep et Python 3.11 ou plus récent.

Windows : installer Git for Windows et Python 3.11 ou plus récent. Utiliser Git Bash, ou PowerShell avec le wrapper suivant :

```powershell
.\.claude\scripts\run.ps1 preflight
```

Les commandes disponibles dans le wrapper sont `init-project`, `preflight`, `verify-before-push`, `run-project-checks`, `generate-github-ci`, `show-project-context` et `doctor`.

## Conception obligatoire

Après le cahier accepté et avant toute implémentation, le Coordinateur exécute :

```bash
bash .claude/scripts/initialize-project-design.sh
```

Le Concepteur complète ensuite `docs/` avec vision, user stories, parcours, architecture, diagrammes, données, contrats, sécurité, roadmap et décisions. Tout document non applicable contient une justification. Chaque work item met à jour les documents touchés et l Auditeur bloque une livraison si le code diverge de la conception.
