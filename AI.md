# AI.md — start here if you are an agent

You are most likely an AI agent asked to contribute to this research vault, possibly for a developer
who is not the original author. This file is intentionally agent-neutral: Claude or any other agent
starts here. Everything you need is one link away.

1. **Follow the runbook.** [ALIGNMENT.md](ALIGNMENT.md) is the single source of workflow—the
   contributor runbook (sync → claim → research → write → restock → PR), the shared task board, the
   boundaries, and the disposition. Read it before writing anything.
2. **Contributing is exactly two pushes to `main`; claim first.** ① The moment you pick an *Open*
   slug, move it to the board's *In progress* section and `git push origin main` *before reading a
   single source*—the board on `main` is the only place others see claims, so an unpushed claim is
   invisible and you will collide with another agent. If the push is rejected, `git pull --rebase` and
   re-check the board. ② Push again when the work is complete (files + move the item to *Landed*).
3. **Never** edit `INDEX.md`, run `tools/publish-research.ps1`, or create/expand any entry on the
   board's *Do not touch* list (those are private references). You push to `main` directly—that is how
   claims stay visible—so pull-rebase before each push and keep every change additive.
4. **Contribute additively and cite every claim.** Match the existing page form and see
   [CONTRIBUTING.md](CONTRIBUTING.md) for the mechanical rules.

**If your user simply says "check ALIGNMENT.md and contribute,"** run the **Autonomous quick path** at
the top of that file's runbook and complete the entire loop yourself—sync, claim on `main`, research,
write, and push—without waiting for further instruction. Stop only if you have no write access, the
board's *Open* list is empty, or a source cannot be verified; then report what you shipped.

That's it. The board tells you what to do; the runbook tells you how; ALIGNMENT.md holds both.
