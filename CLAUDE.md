# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
# Run the main program
odin run .

# Run all tests
for d in */; do odin test "$d" 2>/dev/null; done

# Build without running
odin build .
```

## Project Overview

This is an Odin programming language learning project. The codebase demonstrates:
- Odin's type system (primitive types, complex numbers, quaternions)
- The Sieve of Eratosthenes algorithm as a practical example
- Odin's testing framework using `core:testing`

## Architecture

**Package structure:**
- `main.odin` - Entry point demonstrating Odin types and using the sieve package
- `sieve/` - Self-contained package implementing prime number generation
  - `sieve.odin` - Sieve of Eratosthenes implementation
  - `sieve_test.odin` - Test suite using `@(test)` annotations

**Key Odin patterns used:**
- `[dynamic]T` for heap-allocated dynamic arrays
- `defer delete()` for deterministic resource cleanup
- `&variable` for pass-by-reference with `append()`
- `slice[:]` syntax for converting arrays to slices

## Testing

Tests use Odin's built-in testing module with `@(test)` procedure annotations and `testing.expect_value()` for assertions.

**Testing Rules (based on Google Testing Blog):**

- Test state, not interactions: Verify the system's output/state, not how it was produced internally
- Test behaviors, not methods: Each test should verify one behavior (given/when/then), not one method
- Name tests after behaviors: Use descriptive names like `test_no_primes_exist_when_limit_is_zero`
- Only test public APIs: Don't test private/internal functions directly
- Keep tests complete and concise: Include all information needed to understand the test, exclude irrelevant details
- Use helper functions for common setup: Extract shared verification logic into helpers
- Prefer DAMP over DRY: Tests should be Descriptive And Meaningful Phrases, even if slightly repetitive

## Coding Rules (based on Readable Code)

**Naming:**

- No single-letter variable names (use `index` not `i`, `number` not `n`)
- Use descriptive names that reveal intent (`candidate`, `prime`, `multiple`)
- Function names should describe what they do (`mark_multiples`, `collect_primes`)

**Functions:**

- Each function should do one thing
- Extract nested loops into separate functions
- Keep functions short and focused

**Comments:**

- Comment the "why", not the "what"
- Use comments to explain intent, not to describe obvious code

**Code Structure:**

- Avoid deep nesting (2+ levels of nesting should be extracted)
- Early return to reduce nesting
- Group related code together
