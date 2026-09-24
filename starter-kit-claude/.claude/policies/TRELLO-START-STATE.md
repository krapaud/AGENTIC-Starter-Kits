# Trello card start-state policy

Before any coding, file modification, delegation or technical implementation for a Trello card, the Coordinator must move the active card to the exact `In Progress` list and reread the card from Trello.

The start checkpoint must verify:

- The card exists and has a stable ID and URL.
- The card is in `In Progress`.
- The card has an owner, scope, dependencies and Definition of Done.
- The active work item and `RUNTIME-STATE.md` reference the same card ID.
- The card labels and checklist are present and readable.

The Coordinator must record the transition timestamp, card ID, previous list, new list and reread evidence in the work item and the quality journal. If the card is already in `Done`, `Review` or `Blocked`, the Coordinator must not code against it until the state is reconciled according to the Trello visual system.

If Trello is unavailable, record the attempted transition as a local blocker and use the local work item state. Never claim that the card was moved or synchronized without a successful reread.

## Real-time checklist synchronization

Complete checklist items strictly in dependency order. After each item:

1. Perform the work.
2. Run the required validation.
3. Record the evidence locally.
4. Check only that completed item in Trello.
5. Update the card description or comment with the evidence.
6. Reread the card and confirm the checked item, current list and next open item.
7. Start the next item only after that reread succeeds.

Never check several items retrospectively, check an item before its evidence exists or continue to the next item while Trello is stale or contradictory.
