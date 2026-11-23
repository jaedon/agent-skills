---
name: legacy-c-reimplementation
description: Reimplement a legacy C program from a reviewed behavioral specification while preserving its stated external contract. Use when the user requests a clean implementation based on an existing specification.
---

# Legacy C Reimplementation

## Purpose

Build a new implementation from a reviewed behavioral specification. Use the specification as the requirements. Use the legacy program, source, tests, and samples as evidence where available. Do not copy the legacy design unless the specification requires it.

## Inputs

Read the applicable `AGENTS.md` files and the specification named by the user. The default specification path is `docs/behavior-spec.md`.

Also inspect the project build instructions, tests, fixtures, sample inputs and outputs, and any recorded decisions that apply. Do not assume that a specification is complete or approved merely because the file exists.

## Workflow

### 1. Check the specification and project constraints

- Identify the required behavior, compatibility boundary, target platforms, and build environment.
- Separate confirmed requirements from inferences and unknowns.
- Find contradictions, missing requirements, and choices that affect external behavior.
- If a blocking unknown or conflict affects the design, explain the issue and ask for a decision before implementing that behavior.
- For non-blocking unknowns, choose a safe, reversible default when possible and record the choice.
- Do not change a public API, ABI, file format, protocol, CLI contract, or other stated external behavior unless the user requests that change.

### 2. Inspect the existing project

- Identify the current build and test commands before changing files.
- Inspect the legacy implementation only to understand evidence, dependencies, formats, and known edge cases. Treat it as behavioral evidence, not as implementation material. Do not copy, port, or retain legacy functions, modules, type definitions, or architecture unless the user explicitly requests this or a documented external constraint requires it.
- Before coding, identify which legacy structures, custom types, and build rules are candidates for replacement. Record any item that must remain and the specific compatibility or platform reason for keeping it.
- Identify generated files and local changes. Do not overwrite user work or remove files without a clear task requirement.
- Preserve existing project conventions when they do not conflict with the specification.
- Select the C language standard, APIs, dependencies, and build system for the new implementation. Do not inherit the legacy choices by default. Choose current, stable, maintained options that support the required platforms and deployment targets. Do not select a tool only because it has the newest release.
- Before implementation, compare the existing build system with suitable maintained alternatives. State the selected system and why it fits. Keep the old build system only when a documented constraint requires it, and record that constraint. If migration would break a required target or workflow, preserve that target and explain the limit.
- Use standard C library APIs and standard types when they express the required behavior. Use `<stdint.h>` types for fixed-width values, `size_t` for object sizes and indexes, and `bool` from `<stdbool.h>` for Boolean values when the selected C standard requires it. Do not carry over a custom type that only renames a standard type. Keep a custom type only when it provides a needed abstraction, public compatibility, or domain-specific meaning; document the reason.
- Apply a modern, consistent C style. Do not copy legacy formatting, naming, function size, or module boundaries merely to match the old source. Follow an existing project style guide only when it does not preserve a known problem or conflict with this reimplementation. Otherwise, use clear names, focused functions, explicit ownership, limited global state, and the project's formatter.
- Prefer the simplest design that satisfies the specification and project constraints. Do not add speculative features, single-use abstractions, or configuration that the requirements do not need. Do not treat fewer lines as the goal when a clearer design better expresses the required behavior.
- Use supported compiler and build-tool versions. Enable useful compiler warnings and use maintained static analysis when they fit the target toolchain. Record choices that affect portability, binary compatibility, security, or maintenance.
- Before coding, provide a short design decision summary covering the C standard, build system, type policy, coding style, and retained legacy components. Check that each choice meets the stated constraints, then proceed. Ask the user only when a required compatibility constraint is unclear or a decision changes the specified external contract.

### 3. Set up comparison evidence when available

Use the original executable as a behavioral reference only when it can be run safely and legally in the available environment. It is evidence, not the specification.

- Use a disposable workspace for runs that write files or change state.
- Inspect commands and scripts before running them. Do not run unknown code or binaries without assessing their effects.
- Capture the exact input, command, environment, exit code, stdout, stderr, and generated files for relevant cases.
- Repeat runs when output may depend on time, randomness, address layout, environment, or uninitialized data.
- Do not claim compatibility for behavior that could not be compared or otherwise verified.

If the original program is unavailable or unsafe to run, use the reviewed specification, existing tests, fixtures, and sample results. Record the limits of that evidence.

### 4. Plan and implement in small slices

Before editing, give a brief plan that maps specification sections to implementation units and validation steps. Keep each change focused on a coherent behavior.

For each slice:

1. Implement the specified behavior with clear module boundaries.
2. Add or update tests for the behavior when the project supports tests.
3. Build and run relevant checks when the user has requested verification or the task requires it. If you cannot run them, state why.
4. Compare observable results against supplied expected data or the original program when available.
5. Fix mismatches before moving to dependent behavior, or record an approved intentional difference.

Prioritize the core path first, then error cases, boundary conditions, optional features, and compatibility details. Adapt this order to the dependency graph of the actual program.

### 5. Preserve observable behavior deliberately

For each in-scope case, compare the fields required by the specification. These can include:

- Return values and exit codes.
- stdout and stderr bytes, including line endings and exact text when required.
- Output files, file names, directory layout, file metadata, and side effects.
- File or wire format bytes.
- API/ABI behavior and protocol interactions.
- Error handling and cleanup behavior.

Use fixed inputs and deterministic seeds when available. Normalize timestamps or other variable fields only when the specification permits it. Do not hide differences through normalization when those differences are part of the contract.

Classify each comparison as:

- **PASS**: all required observable fields match.
- **EXPECTED DIVERGENCE**: the implementation differs by a documented decision or a safe handling of legacy undefined behavior.
- **FAIL**: a required field does not match and no accepted decision explains the difference.

### 6. Handle undefined or unstable behavior

Do not reproduce undefined behavior, memory corruption, or unstable output merely to match one run. First determine whether the behavior is part of a documented external contract.

When behavior is unstable:

- Repeat the case and record the varying results.
- Identify which output fields are stable and which are not.
- Implement a safe deterministic result when the specification allows that choice.
- Record the behavior difference and its effect on compatibility.
- Ask the user to decide when the difference changes a documented contract or data format.

### 7. Resolve conflicts and record decisions

When the specification, existing tests, and original program disagree, report the evidence and affected requirements. Do not silently treat one source as authoritative.

Follow recorded project decisions. If no decision exists and the conflict changes external behavior, pause that part of the implementation and ask the user to choose. Record the selected behavior in the project decision log or specification, if one exists.

### 8. Finish and hand off

Summarize:

- Implemented features and the specification sections they satisfy.
- External behavior preserved or intentionally changed.
- Tests, builds, and comparisons performed, with results.
- Unresolved items, unverified behavior, and known limitations.
- Files changed and current repository status when available.

Do not claim full compatibility when required cases remain unverified.

## Completion criteria

The work is ready for review when the implementation covers the agreed scope, relevant checks have run or their limits are stated, required comparisons have results, and all intentional differences and open issues are documented.

The handoff must also state which C standard, build system, standard APIs and types, and coding style the implementation uses. List each retained legacy component and its reason. If the implementation reuses legacy code or keeps the old build system, identify the exact user request or documented constraint that requires it.
