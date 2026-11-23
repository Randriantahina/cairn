---
paths:
  - "{{BACKEND_PATH}}**"
---
# Backend: simple layers ({{BACKEND_STACK}})

For small projects. Three layers, no ceremony. Promote to DDD only when a rule below starts to hurt.

| Layer | Holds |
|-------|-------|
| Controller / handler | validate input, call one service, shape the response |
| Service | business logic and transactions |
| Repository | queries only |

## Rules
- A controller never queries the database; a repository never holds business rules.
- Validate input at the boundary; return typed errors, not raw exceptions.
- Plain objects (DTOs) between controller and service, not request or model objects.
- Introduce a pattern (strategy, factory, adapter) only when you have a second case that needs it.
- Every service and endpoint has a test.

## When to promote to layered DDD
A service passes ~300 lines, two features share rules, or you add a third-party integration. Record the decision in `memory/decisions/`.

Good: 5 tables, controller → service → repository.
Bad: events, value objects and a domain layer for a CRUD that has no rules.
