# Game Dev Research Vault

An open, source-backed Obsidian vault for practical game-development research.

Clone the repository, then open its folder as a vault in Obsidian. The published notes live under
`wiki/`; source-summary pages retain the original URLs and retrieval dates so readers can check
claims against their sources.

## Included

- Game-design systems: clickers, MMOs, and progression
- Blender pipelines, game assets, and VRChat avatar creation
- Unity, Unreal, optimisation, and editor MCP workflows

## Publishing policy

This repository contains research notes and source provenance only. It intentionally excludes
private project notes, local paths, machine configuration, logs, chat-specific memory, and full
copies of third-party source material.

## Updating the vault

From the repository root, run:

```powershell
.\tools\publish-research.ps1
```

The script exports tagged game-development notes from the private brain, commits a changed export,
and pushes it to `origin` when a remote and Git identity are configured.

## License

See [LICENSE.md](LICENSE.md). Source pages cite the original authors and URLs; they do not grant
rights to third-party source material.
