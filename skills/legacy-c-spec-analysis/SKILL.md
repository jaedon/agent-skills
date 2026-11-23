---
name: legacy-c-spec-analysis
description: Analyze a legacy C program and produce a source-backed behavioral specification for an independent reimplementation. Use before implementation when behavior, file formats, command-line interfaces, or compatibility requirements need to be documented.
---

# Legacy C Specification Analysis

## Purpose

Create a behavioral specification that an engineer can use to implement the program without relying on the legacy code structure. This skill is for analysis and documentation. Do not implement, refactor, or clean up the program during this workflow.

## Inputs

Use the repository and any supplied requirements, test results, sample files, and runtime access. Read the applicable `AGENTS.md` files first. If the repository has project instructions for another agent, read those when they apply.

The default output is `docs/behavior-spec.md`. Use a different path only when the user or repository instructions specify one.

## Workflow

### 1. Establish scope and constraints

- Identify the program or component that the user wants documented.
- Identify the source tree, build system, supported targets, and existing tests.
- Record the requested compatibility boundary, such as CLI behavior, API/ABI, file formats, protocols, logs, exit codes, or generated files.
- Do not assume that every internal behavior must remain compatible. Use the user’s stated requirements and project instructions to define scope.
- If the target or compatibility boundary cannot be determined from the request and repository, document the uncertainty and ask focused questions before making consequential assumptions.

### 2. Inspect the project without changing it

- Read relevant source files, headers, build files, tests, fixtures, and user documentation.
- Trace the main execution paths from inputs to outputs and side effects.
- Inspect platform and compiler conditionals, feature flags, and generated code when they affect behavior.
- Do not modify source, build, test, or configuration files. Write only the requested specification and any explicitly requested analysis report.
- Do not run unknown binaries or scripts automatically. Inspect their purpose first. If execution is needed, use a disposable workspace and follow repository safety rules.

### 3. Gather behavioral evidence

For each user-visible feature, record:

- Inputs, defaults, accepted forms, and validation rules.
- Processing rules and state changes that affect later behavior.
- Outputs, return values, logs, exit codes, and generated or modified files.
- Error behavior and cleanup on failure.
- Boundary cases, such as empty, oversized, malformed, truncated, or duplicate input.
- Platform, compiler, build-option, dependency-version, and environment differences.

Use existing tests and supplied examples as evidence. Run the program only when execution is safe and available, and only in a disposable location when it can write files or perform external actions. Preserve exact output bytes when compatibility requires them. Record the command, environment, and observed result for each important experiment.

Do not treat the source code as proof of intended behavior when code and tests disagree. Record the disagreement. Do not infer a required behavior from a single test or a single run when the result can vary.

### 4. Mark evidence and uncertainty

Label each requirement as one of:

- **Confirmed**: supported by repeatable runtime evidence, an authoritative requirement, or consistent tests and implementation evidence.
- **Inferred**: the best explanation of available evidence, but not directly confirmed.
- **Unknown**: evidence is missing, conflicting, or insufficient.

For every item, cite the relevant source file and symbol or line range when available. Also cite tests, fixtures, commands, and observed results that support runtime claims. Separate observable requirements from explanations of the current implementation.

When evidence conflicts, state the conflict and list the decision needed. Do not silently choose which source of evidence is authoritative.

### 5. Write the specification

Create `docs/behavior-spec.md` with these sections, adapting them to the program:

1. Purpose and scope
2. Build and run environment
3. External interfaces and compatibility requirements
4. Features and behavior
5. Inputs, outputs, side effects, and errors
6. State, initialization, shutdown, and resource ownership, when relevant
7. Platform and dependency differences
8. Evidence and source references
9. Confirmed behavior, inferences, and unknowns
10. Open questions and decisions required before implementation
11. Test cases and sample data needed for compatibility checks

For complex behavior, include tables or examples. Describe required outcomes, not a proposed copy of the original architecture. Keep implementation advice separate from behavioral requirements.

### 6. Review the specification

- Make sure that each in-scope feature has inputs, expected behavior, outputs, and error behavior where relevant.
- Make sure that each compatibility claim has evidence or an explicit uncertainty label.
- Make sure that source references identify the code or test that supports the claim.
- Make sure that assumptions are visible and that unresolved decisions are not written as requirements.
- Make sure that the specification does not prescribe a specific design unless a design constraint is part of the requirements.

## Completion report

When the specification is complete, report:

- The specification path.
- The analyzed scope.
- The main evidence sources and any runtime experiments.
- Open questions that block or affect reimplementation.
- Important behaviors that could not be confirmed.

Do not begin implementation in this workflow. The next implementation session must use the reviewed specification as its requirements and must resolve any blocking unknowns first.
