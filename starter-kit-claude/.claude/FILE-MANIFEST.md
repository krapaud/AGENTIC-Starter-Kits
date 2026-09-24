# Manifeste de complétude

## Fichiers obligatoires du noyau

- `KIT.toml`, `ORCHESTRATION.md`, `GOVERNANCE.md`, `PROJECT-CONTEXT.md`, `PROJECT-DATA-BOUNDARY.md`
- `RISK-MATRIX.md`, `RUNTIME-STATE.md`, `MODEL-POLICY.md`, `models.toml`, `COST-AND-EVALUATION.md`, `ADAPTERS.md`
- Agents optionnels activables dans `agents/` : `produit`, `qa`, `devops`, `performance`, `ux-research`, `accessibilite`, `data`, `documentation`, `release` et `conformite`.
- `SPECIALIST-AGENTS.md` définit leur activation, leurs livrables et leur ordre de contrôle.
- `policies/EXCEPTIONAL-REQUESTS.md` définit la classification des demandes exceptionnelles.
- `policies/`, `agents/`, `prompts/`, `skills/`, `scripts/`, `templates/`, `evaluations/`
- `policies/DOCUMENTATION-LANGUAGE-POLICY.md` impose la qualité et la langue des documents techniques.
- `policies/TRELLO-VISUAL-SYSTEM.md` définit les listes, étiquettes et règles de lisibilité Trello.
- `policies/TRELLO-START-STATE.md` impose le passage dans `In Progress` et la synchronisation séquentielle.

## Attentes de qualité

Chaque Skill Claude est placé dans `skills/<nom>/SKILL.md` et commence par un frontmatter YAML avec `name` et `description`. Chaque sous-agent Claude est un fichier Markdown dans `agents/` avec frontmatter YAML. Chaque script est non interactif, échoue explicitement en cas de précondition manquante et ne détruit pas de fichier existant.

## Auto-contrôle

`preflight.sh` vérifie la présence du noyau, la syntaxe TOML, les rôles, les frontmatters des sous-agents et Skills, les modèles autorisés, les sections des Skills, les prompts requis, les secrets manifestes, les tirets cadratins et le nombre de work items actifs.

## Révision

Revoir ce manifeste après une nouvelle catégorie de tâche, une défaillance de qualité, un incident ou une optimisation de coût significative.
