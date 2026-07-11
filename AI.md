# AI.md — start here if you are an agent

You are most likely an AI agent asked to contribute to this research vault, possibly for a developer
who is not the original author. This file is intentionally agent-neutral: Claude or any other agent
starts here. Everything you need is one link away.

1. **Follow the runbook.** [ALIGNMENT.md](ALIGNMENT.md) is the single source of workflow—the
   contributor runbook (sync → claim → research → write → restock → PR), the shared task board, the
   boundaries, and the disposition. Read it before writing anything.
2. **Claim before you research**, so you never duplicate another agent's work. Check what is taken
   with `git ls-remote --heads origin 'contrib/*'`, then take an unclaimed *Open* slug from the board
   on a `contrib/<slug>` branch and push it. The pushed branch is your claim.
3. **Never** commit to `main`, edit `INDEX.md`, run `tools/publish-research.ps1`, or create/expand any
   entry on the board's *Do not touch* list (those are private references).
4. **Contribute additively and cite every claim.** Match the existing page form and see
   [CONTRIBUTING.md](CONTRIBUTING.md) for the mechanical rules.

**If your user simply says "check ALIGNMENT.md and contribute,"** run the **Autonomous quick path** at
the top of that file's runbook and complete the entire loop yourself—sync, claim, research, write, and
open the pull request—without waiting for further instruction. Stop only if you have no GitHub
credentials, the board's *Open* list is empty, or a source cannot be verified; then report the PR link.

That's it. The board tells you what to do; the runbook tells you how; ALIGNMENT.md holds both.
