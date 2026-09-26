# Trello Visual System

## Purpose

Every project board must be immediately understandable without reading every card. The Coordinateur creates or reuses a consistent visual system before creating cards.

## Standard lists

Create missing lists in this order:

1. `Inbox`
2. `Ready`
3. `In Progress`
4. `Blocked`
5. `Review`
6. `Done`
7. `Archived`

Use `Inbox` only for captured requests. Move a card to `Ready` after its scope, owner, dependencies and Definition of Done are complete. A card remains in `In Progress` while work is active. Use `Blocked` only with a documented blocker and next action. Use `Review` only when implementation is complete and a real review remains. Use `Done` only after every checklist item is proven.

### Dimensionnement selon l'équipe

Les listes de gouvernance restent stables (`Inbox`, `Ready`, `Blocked`, `Review`, `Done`, `Archived`). Les colonnes de travail remplacent `In Progress` selon le nombre de personnes réellement affectées au projet, après déduplication des membres et confirmation de leur rôle :

`work_columns = min(4, max(1, ceil(active_members / 2)))`

- 1 ou 2 personnes : une colonne `In Progress`.
- 3 ou 4 personnes : `In Progress 1` et `In Progress 2`.
- 5 à 8 personnes : trois colonnes de travail.
- 9 personnes ou plus : quatre colonnes maximum.

Chaque colonne de travail doit avoir un responsable ou un groupe clairement documenté. Ne pas créer une colonne par personne lorsque cela produit un tableau vide ou artificiellement fragmenté. Si les membres ne sont pas confirmés, conserver une seule colonne `In Progress` et demander la clarification avant d'en créer d'autres. Le Coordinateur réévalue ce dimensionnement lorsque l'équipe change de taille.

## Standard labels

Create or reuse these labels with the same names and colors:

| Label | Color | Meaning |
| --- | --- | --- |
| `Feature` | Green | New product capability. |
| `Bug` | Red | Defect or regression. |
| `Security` | Orange | Security, privacy or compliance risk. |
| `Architecture` | Purple | Architecture or design decision. |
| `Frontend` | Blue | User interface or client work. |
| `Backend` | Blue | API, service or server work. |
| `Data` | Yellow | Database, migration or data contract. |
| `DevOps` | Black | CI, deployment or infrastructure. |
| `Documentation` | Sky | Documentation or knowledge transfer. |
| `QA` | Lime | Testing and validation. |
| `Blocked` | Red | Active blocker. |
| `Priority: High` | Orange | Must be handled before normal work. |
| `External validation` | Pink | Human, legal, client or external evidence required. |

Use at least one type label and one domain label. Add risk, priority and validation labels only when relevant. Never create near-duplicate labels such as `frontend`, `Front end` and `UI`.

## Card naming

Use the format `[WI-XXX] Verb + precise outcome`. Keep titles short, unique and action-oriented. Do not encode status, dates or unchecked progress in the title. Status belongs to the list and labels belong to the visual taxonomy.

## Card layout

The first lines of every description must contain:

```text
Owner: <name>
Type: <Feature|Bug|Architecture|...>
Priority: <Low|Medium|High|Critical>
Dependencies: <IDs or None>
Definition of Done: <short statement>
```

Then use the headings `Context`, `Scope`, `Implementation plan`, `Acceptance criteria`, `Evidence`, `Risks`, `Rollback` and `Definition of Done`. Use real line breaks, short paragraphs and Markdown checklists. Never encode newlines as literal `\\n`.

## Synchronization rules

Before creating cards, inspect existing lists and labels and reuse matching objects by stable ID or exact name. Create only missing objects. After synchronization, reread the board, lists, labels, card descriptions, members, due dates and checklists. Record all IDs and URLs in the local board document.

After every status change, assignment, checklist update, delivery, correction or merge, synchronize the card immediately. If the visual state and the local work item disagree, correct both before continuing.

## Accessibility and clarity

Labels must not be the only way to understand a card. The title, list, first description block and checklist must remain meaningful without color. Do not overload cards with more than five labels unless the extra labels carry a real decision or risk signal.
