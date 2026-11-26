# Agent Skills

This repository contains reusable skills for AI agents. Each skill provides guidance for a specific task or area of work.

## Skills

| Skill | Use it when |
| --- | --- |
| [Legacy C Specification Analysis](skills/legacy-c-spec-analysis/SKILL.md) | You need a source-backed description of a legacy C program's behavior before reimplementation. |
| [Legacy C Reimplementation](skills/legacy-c-reimplementation/SKILL.md) | You need to build a new implementation from a reviewed behavioral specification. |
| [Korean Business Copyediting](skills/korean-business-copyedit/SKILL.md) | You need to copy-edit Korean prose in tech or business documents while preserving facts and terminology. |

## Install

Replace `<username>` with the GitHub account that owns this repository. List the available skills, then install the selected skills globally for the listed agents:

```sh
npx skills add <username>/skills --list

npx skills add <username>/skills \
  --skill legacy-c-spec-analysis \
  --skill legacy-c-reimplementation \
  --skill korean-business-copyedit \
  --global \
  --agent codex claude-code opencode cursor
```

## Repository Structure

Each skill has its own directory under `skills/`. The `SKILL.md` file in each directory is the main guide. A skill can also include supporting resources in that directory. The repository can include skills for different tasks and fields.

## Contributing

Read the relevant `SKILL.md` before editing a skill. Preserve its purpose, scope, and workflow. For documentation changes, inspect the full edited file and run `git diff --check` and `git diff` before submitting the change.
