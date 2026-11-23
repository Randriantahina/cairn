---
paths:
  - "{{FRONTEND_PATH}}**"
---
# Frontend: components + hooks ({{FRONTEND_STACK}})

For small apps. Keep it flat; split when it hurts.

## Rules
- Components render; logic that is reused or tested lives in a hook/composable/helper, not inline.
- Data access goes through one small module (`api/`), never scattered `fetch` calls.
- State: local first, shared only when two distant components need it.
- Validate forms with a schema; type every prop and event.
- Every hook, helper and non-trivial component has a test.
- Package manager: `{{PACKAGE_MANAGER}}` only.

## When to move to feature-sliced MVVM
Three screens share the same entity, or a component passes ~200 lines. Record it in `memory/decisions/`.

Good: `useInvoices()` returns data and actions; the screen renders them.
Bad: 400 lines of fetch, state and markup in one component.
