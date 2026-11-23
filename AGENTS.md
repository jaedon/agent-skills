# Repository Guidelines

## Project Structure

This repository contains skills. Each skill has its own directory under `skills/` and uses a `SKILL.md` file as its main guide. A skill can also include supporting resources in its directory. There is no application source or test suite in the current tree.

Keep each skill's instructions in its own directory. Put shared material in a separate file under `skills/` only when more than one skill uses it. Link to that file from each relevant `SKILL.md`.

## Build and Development

The repository has no build system or local start command. Edit Markdown files directly. Before you submit a change, inspect the diff with `git diff --check` and `git diff`. These commands find whitespace errors and show the edits. There is no automated test command in the current repository.

## Writing Style and Naming

Use clear, direct English. Write actionable instructions in the imperative mood. Keep headings descriptive and use sentence case. Give each skill directory a short, descriptive name. Use lowercase words separated by hyphens. Name the main guide `SKILL.md`.

Keep the YAML header at the top of each `SKILL.md`. Include the skill name and a short description. Use Markdown headings to organize the guide. Keep commands, paths, identifiers, and quoted output exact.

## Review and Testing

No test framework or coverage target exists. For documentation changes, read the full edited file and make sure that links, commands, paths, and section references match the repository. If you add executable examples or supporting scripts, document how contributors can use them. Add automated checks only when the repository gains a clear need for them.

## Commits and Pull Requests

The Git history has no commits, so this repository has no established commit format. Use a short imperative commit subject that names the change, for example, `Add a skill guide`.

In a pull request, describe the purpose and affected skill directories. List the documentation or manual review steps that you completed. Link a related issue when one exists. Screenshots are not needed for text-only changes.

## Agent Instructions

Read the relevant `SKILL.md` before you change a skill. Preserve its purpose, scope, and workflow. Keep shared guidance consistent across skills. Add new skills in their own directories and document any supporting resources they need.
