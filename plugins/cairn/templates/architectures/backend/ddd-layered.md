---
paths:
  - "{{BACKEND_PATH}}**"
---
# Backend: layered DDD ({{BACKEND_STACK}})

Dependencies point inward only: `Interface → Application → Domain ← Infrastructure`.

| Layer | Holds | May import |
|-------|-------|-----------|
| Domain | entities, value objects, enums, domain events, **repository interfaces** | nothing outside itself |
| Application | services (use cases), DTOs | Domain |
| Infrastructure | repository implementations, adapters (mail, PDF, payment, queue) | Domain |
| Interface | controllers/handlers, request validation, response mapping, authorization | Application, DTOs |

## Patterns (use only when the problem is present)
- **Repository**: every query lives behind an interface; no controller or service touches the ORM or SQL.
- **Service**: business logic; one use-case family per class. Controllers validate, map to a DTO, call one service, return.
- **DTO**: immutable; the only thing that crosses a layer. Never pass a request object or a raw model inward.
- **Value object**: immutable, self-validating (`Money`, `Email`). No primitive obsession for rules-bearing values.
- **Strategy**: replace an `if/else` chain that varies by type (pricing, format, payment mode).
- **Factory**: construct an entity that has invariants. **Adapter**: wrap every third party behind your own interface.
- **Domain event / observer**: side effects (audit, notification) without coupling the use case to them.
- **Unit of work**: one transaction per use case, opened in the service.

## SOLID, as checks
- S: a class you describe with "and" is two classes.
- O: a new variant is a new class, not a new `case` in an old `switch`.
- L: every implementation passes the same contract test as its interface.
- I: small role interfaces; a mock never needs unused methods.
- D: depend on interfaces, inject through the constructor; no service locator or global in Domain/Application.

## Checkable
- No ORM/SQL import in Domain or Application. No framework import in Domain.
- Every service and repository has a test; every endpoint has an authorization test.
- Money and other precise values are never floats.

Good: `PaymentService` calls `PaymentRepository` (interface) inside one transaction.
Bad: a controller calling `Model::where(...)->update(...)`.
