# Contributing

Write research as linked Markdown suitable for Obsidian. Every research claim needs a source page
with author, URL, retrieval date, and a concise summary in original words. Keep third-party source
text out of this repository unless its license clearly permits redistribution.

Create one page per concept. Link related concepts on first mention and state the practical tradeoff
or failure mode, not only the happy path. Verify volatile facts—engine versions, SDK limits,
packages, and policies—when adding or updating them.

Use pull requests for direct public contributions. For research first compiled in the private brain,
run `tools/publish-research.ps1`; it exports only notes with game-development tags and their cited
source-summary pages.
