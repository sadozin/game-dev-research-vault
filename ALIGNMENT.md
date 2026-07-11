# Alignment

This document explains the *intent* behind contributions so future work stays in line with what
already exists. Read it alongside [CONTRIBUTING.md](CONTRIBUTING.md): that file states the mechanical
rules, this one states the disposition.

**This is a shared, editable coordination file.** Any contributor—human or an AI working on another
dev's behalf—is invited to edit it: take a topic from the [Shared task board](#shared-task-board),
and leave the board better stocked than you found it. The steps to follow are the
[Contributor runbook](#contributor-runbook). Keep this file in sync with reality; a stale board is
worse than none.

## Shared task board

**Pick a topic from *Open* below, then follow the [Contributor runbook](#contributor-runbook)** (or
its autonomous quick path). When you finish, move the item to *Landed* with the date and the files you
added. When you notice a new gap, add it to *Open* with a one-line reason and where the vault already
reaches for it. Each *Open* item's **bold id is its slug**; claim it on a `contrib/<slug>` branch.
Keep this board current—it is the point of coordination between contributors.

### Open (pick from here)

- **idle-game-math-part-ii** — Parts I and III are cited sources; the middle of Pecorella's public
  series is missing. Add the source page and thread it into `clicker-game-economy` and
  `idle-game-prestige`. (Note: threading requires touching those two concept pages' `sources:`.)
- **texture-atlasing** — referenced in spirit by `draw-call-batching` and `vrchat-avatar-optimization`
  (both say "atlas textures to keep batches") but never defined on its own.
- **action-combat-roles** — `mmo-combat-roles` sets up the holy trinity but not action-combat role
  design (aggro without a taunt, telegraphs, sustain vs. burst); a natural neighbour concept.
- **prestige-currency-soft-caps** — deepens `idle-game-prestige`; how stacked reset currencies and
  soft/hard caps shape a long idle curve.
- **object-pooling** — neighbours `game-performance-profiling`; allocation-stall avoidance for
  frequently spawned entities.

### Landed

- **draw-call-batching** (2026-07-11) — `wiki/concepts/draw-call-batching.md`,
  `wiki/sources/nvidia-batch-batch-batch.md`, `wiki/sources/unity-draw-call-batching.md`. The
  batching concept the optimization cluster kept implying but never defined.
- **blender-mcp** (2026-07-11) — `wiki/concepts/blender-mcp.md`,
  `wiki/sources/ahujasid-blender-mcp.md`. Completes the Unity/Unreal/Blender editor-MCP trilogy and
  resolves the dangling `[[blender-mcp]]` links.
- **level-of-detail** (2026-07-11) — `wiki/concepts/level-of-detail.md`, published by the maintainer
  via the export tool. If it reads thin, a follow-up may deepen the "the catch" (LOD popping, switch
  distance tuning) rather than re-create it.

### Do not touch (private references; never publish or expand)

These appear as dangling links inside published notes. They are private projects or machine config.
Do not create pages for them, and do not add new references to them.

- `minecwaft` — private Vulkan/C# game
- `micro-mmo` — private MMO project
- `vrchat-homeworld` — private VRChat world
- `unity-mcp` — machine-specific connection/config notes
- `arii-blend-avatar` — a specific personal avatar project (treat as private unless the maintainer
  confirms it is a public base)

## The disposition: additive, not architectural

Contribute as a **source contributor**. The job is to continue the research already here—deepen a
thread, add a missing source, fill a gap between two concepts—so that if the change were pulled, an
existing reader gains something and loses nothing. A good contribution is a drop-in: it reads as
though the same author wrote it on the same day.

Do not reshape the vault. No new top-level structure, no renamed folders, no reorganised index, no
competing conventions, no tooling rewrites. If a change would make a maintainer decide *how the
project works* rather than *what it knows*, it is out of scope here—raise it as a discussion first.

Ask of every change: **would pulling this help someone already using the vault?** If the answer is
"only after they adapt to a new way of doing things," stop.

## What a good contribution looks like

- Extends an existing concept, or adds a concept that neighbours one already present and links to it.
- Comes with its source page(s). Every claim traces to a cited source with author, URL, published
  date, retrieval date, and a summary written in original words—never pasted source text.
- States the tradeoff or failure mode, not just the happy path. The value is in the "the catch"
  and "in practice" reasoning, not a restated summary.
- Links related concepts on first mention with `[[wikilinks]]`, matching the existing graph.
- Verifies volatile facts (engine versions, SDK limits, package names, platform policies) at the time
  of writing, and sets `verified:` to that date.

## Match the existing form exactly

New pages copy the shape of the current ones—do not invent frontmatter fields or section headings.

- **Concept pages** (`wiki/concepts/`): frontmatter `title, type: concept, status, created, updated,
  verified, sources, tags`; body with a lead definition, a "why it works" mechanism, a "the catch"
  limitation, and an "in practice" application. See [frame-pacing.md](wiki/concepts/frame-pacing.md).
- **Source pages** (`wiki/sources/`): frontmatter `title, type: source, status, created, updated,
  verified, sources, tags`; body with an author/URL/dates block, a "summary" in original words, and a
  "compiled into" list of the concepts it feeds. See
  [idle-game-math-part-i.md](wiki/sources/idle-game-math-part-i.md).

Keep prose tight and concrete, wrapped at roughly the same width as surrounding files. Tags reuse the
existing vocabulary rather than introducing near-duplicates.

**Provenance for direct contributions.** Notes exported from the private brain point a source page's
`sources:` field at a private `raw/…` capture. A direct public contribution has no such capture, so
point `sources:` at the live public URL instead and drop the `Raw:` bullet—cite honestly rather than
name a file that does not exist. Everything else about the form stays identical.

## Boundaries

- No private-project notes, local paths, machine configuration, logs, or chat-specific memory. This is
  a public export; if a note references a private project or workspace, leave it out or generalise it.
- No third-party source text unless its license clearly permits redistribution. Store attribution,
  URLs, and original summaries—not the works themselves.
- Generated pages under `wiki/` originate from the private brain. As an outside contributor you add
  new files under `wiki/` for a direct public pull request; the maintainer folds them into the brain.
- **Do not run `tools/publish-research.ps1`.** It is the maintainer's export tool: it wipes and
  regenerates `wiki/` and `INDEX.md` from a private brain that is not part of this repository, so
  running it would delete unmerged contributions. Leave `INDEX.md` untouched too—it is generated.

When in doubt, the smaller, better-sourced, more clearly-linked change is the right one.

## Contributor runbook

A fresh agent—human or AI, working for any developer—should be able to run these steps in order and
contribute cleanly. Coordination happens through **pull requests against `main`** and the task board
below. **Never commit research directly to `main`**: it is the maintainer's publish target and is
overwritten wholesale by the export tool, so a direct commit there is unsafe and likely lost.

**You need GitHub access to contribute.** Reading and pulling a public repo needs nothing special,
but *landing* work needs an account that can open a pull request here—either write access (ask the
maintainer to add you) or your own fork (`gh repo fork`). With no GitHub credentials at all you can
research and draft locally but cannot submit; hand the files to someone who can. The maintainer sets
this—see [Access model](#access-model).

**The claim is an open pull request, not a branch on the main repo.** A draft PR against `main` is
visible to every contributor—collaborator or forker—through `gh pr list`; a branch pushed to your
fork is not. The lock keys off PRs for exactly that reason.

**Autonomous quick path.** If a user simply says *"check ALIGNMENT.md and contribute,"* run the whole
loop below yourself—sync, claim, research, write, and open the pull request—**without stopping to
ask**. Only pause if (a) you have no GitHub credentials, (b) the *Open* list is empty, or (c) you
cannot verify a source. When done, report the PR link and what you shipped. The annotated steps 0–5
that follow explain each command; this block is the executable distillation.

```bash
REPO=sadozin/game-dev-research-vault

# 0. Sync to the latest board and landed work.
git switch main && git pull --ff-only origin main

# Decide where you can push: WRITE/ADMIN -> origin; otherwise fork.
ACCESS=$(gh repo view $REPO --json viewerPermission -q .viewerPermission)
if [ "$ACCESS" = "WRITE" ] || [ "$ACCESS" = "ADMIN" ]; then REMOTE=origin; \
  else gh repo fork $REPO --remote --remote-name fork; REMOTE=fork; fi

# 1. See what is already claimed, then pick an unclaimed Open slug from the board.
gh pr list --repo $REPO --state open

# 2. Claim BEFORE researching: branch, push, open a draft PR (the claim).
git switch -c contrib/<slug>
git commit --allow-empty -m "contrib/<slug>: claim"
git push -u $REMOTE contrib/<slug>
gh pr create --repo $REPO --draft --base main \
  --title "contrib/<slug>: <short title>" --body "Claiming <slug> per ALIGNMENT.md; research in progress."

# 3-4. Research with cited sources; write new wiki/ files in the existing form (steps 2-3 below).

# 5. Finish: restock the board, commit, push, mark the PR ready.
git commit -am "contrib/<slug>: add notes and restock board"
git push
gh pr ready "$(gh pr list --repo $REPO --head contrib/<slug> --json number -q '.[0].number')"
```

**0 — Sync and read.**

- `git fetch origin && git switch main && git pull --ff-only origin main` so you hold the latest
  board and landed work.
- Read this file top to bottom and [CONTRIBUTING.md](CONTRIBUTING.md); skim one concept and one
  source page to absorb the voice before writing.
- Re-read the [Shared task board](#shared-task-board) *after* pulling—an item you remember as open
  may already have landed.

**1 — Claim *before* you spend research tokens.** Claiming first is the one rule that stops two
agents researching the same item.

- Each *Open* item has a **slug** (its bolded id). Use it for both your branch (`contrib/<slug>`) and
  your PR title (begin the title with `contrib/<slug>`), so the claim is unambiguous.
- Check what is taken: `gh pr list --repo sadozin/game-dev-research-vault --state open`. If an open PR
  already carries your slug, it is claimed—pick another. (`git ls-remote --heads origin 'contrib/*'`
  is a quick extra check, but it only sees branches on the main repo, never forks, so it is not
  sufficient on its own.)
- Claim it: branch `git switch -c contrib/<slug>`, make a first commit (moving the item out of *Open*
  is fine), push it—to `origin` if you have write access, otherwise to your fork—and immediately open
  a **draft PR** against `main`. That draft PR is your lock; open it *before* you research.
- Stale claim: a draft PR with no new commits for 7 days is abandoned. Say so on it, then take the
  item. If two claims still race, the first merged wins and the other rebases onto `main` and repicks.

**2 — Research and verify.**

- Fetch the real sources. Capture author, URL, published date, and retrieval date; write summaries in
  your own words—never paste source text. Re-check volatile facts (versions, limits, policies) and
  set `verified:` to today.

**3 — Write additively, in the existing form.**

- Add new files under `wiki/concepts/` and `wiki/sources/` matching the frontmatter and section shape
  in [Match the existing form exactly](#match-the-existing-form-exactly).
- Link out to existing concepts—Obsidian backlinks connect the graph without editing the notes you
  point at. Reference only public concepts; never the *Do not touch* list.
- Do not add structure, rename anything, edit `INDEX.md`, or run `tools/publish-research.ps1`.

**4 — Restock the board.**

- Move your item to *Landed* with date and files. Add any new gaps to *Open* (one line: the reason
  and where the vault already reaches for it), and any private references you found to *Do not touch*.
  Leaving the next contributor a well-described task is part of the contribution.

**5 — Open the pull request.**

- Commit your `wiki/` files and the board update together, push the branch, and mark the PR ready
  against `main`. Merged files are provisional until the maintainer folds them into the private brain
  (see [Durability of contributions](#durability-of-contributions)); expect your exact wording may be
  revised there.

## Access model

*Maintainer: confirm which of these applies and delete this line.*

**Default — fork and pull request.** Any agent or person with a GitHub account forks the repo
(`gh repo fork sadozin/game-dev-research-vault --clone`), pushes their `contrib/<slug>` branch to that
fork, and opens a PR against `main`. No one gets write access to the main repo; the maintainer merges.
This needs no admin step and is why the claim keys off the PR (visible to all) rather than a branch on
the main repo (only visible to people who can push there).

**Optional — named collaborators.** The maintainer may instead grant specific people or agents write
access, letting them push `contrib/<slug>` branches straight to the main repo. The claim is still the
open PR. If you use this, list here who has access and how to request it.

Either way, an agent with **no** GitHub credentials cannot land work—it can only draft locally and
hand off. That is a property of GitHub, not of this workflow.

## Durability of contributions

*A note for the maintainer. Suggestions only—nothing here changes the export tool, and contributors
must not touch it.*

Merged contributions on `main` are currently **provisional**. `tools/publish-research.ps1` rebuilds
`wiki/` by deleting every note and re-copying from the private brain, so a merged pull request that
has not also been added to the brain is silently removed by the next publish—no conflict, no warning.
The *Landed* list can then claim files that no longer exist on `main`. Contributors cannot fix this;
the runbook only tells them to expect it.

Two ways to close the gap, in order of preference:

1. **Make publish non-destructive and fail-loud (recommended).** Have the script remember what it
   exported (a manifest) and, on the next run, prune only files it previously produced that the brain
   no longer produces—leaving contributed files untouched—then print any `wiki/` file it does not own
   as "unmanaged: fold into the brain to keep it." This ends silent deletion while still letting the
   brain prune its own renamed or removed notes.
2. **Mirror-before-publish checklist.** If the tool stays destructive, then before every publish
   confirm that each pull request merged since the last publish is present in the brain. This works
   but relies on discipline; option 1 makes the safety automatic.

Until one of these is in place, fold each merged pull request into the brain promptly, and keep the
*Landed* list honest by removing any entry whose files a publish has dropped.

When in doubt, the smaller, better-sourced, more clearly-linked change is the right one.
