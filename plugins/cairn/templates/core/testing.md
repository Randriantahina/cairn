# Testing: {{TEST_APPROACH}}

Runner: `{{TEST_COMMAND}}` · single test: `{{TEST_ONE_COMMAND}}`

## Rules
- Every new class, function or component ships with a test in the same change.
- A bug fix starts with a test that reproduces the bug.
- Test names state the behaviour: `it('refuses a payment above the balance')`.
- One reason to fail per test; no shared mutable state; no order dependence.
- Mock only at architectural boundaries (repository, HTTP gateway, clock). Never the class under test, never the database in integration tests.
- Freeze time for anything date-dependent.
- Fixtures use factories and fake data, never real personal data.
{{TDD_BLOCK}}
## Before declaring done
Run: {{GATE_COMMANDS}}
Report the real output. If something failed or was skipped, say so.

Good: failing test committed, then the minimum code to pass, then refactor.
Bad: code first, tests "added later".
