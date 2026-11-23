---
paths:
  - "{{FRONTEND_PATH}}**"
---
# Frontend: feature-sliced MVVM ({{FRONTEND_STACK}})

Each feature owns its three roles; shared code stays generic.

```
features/<feature>/
  domain/        types, validation schemas, pure rules        (Model)
  data/          repository over the API client or local DB   (Model)
  *.viewmodel    state and commands, repository injected      (ViewModel)
  ui/            presentational components                    (View)
shared/          api client, i18n, utilities, design-system wrappers
```

## Rules
- **View**: renders state and emits events. No fetch, no business rule, no storage access.
- **ViewModel**: owns state and commands; receives its repository by injection so tests pass a fake.
- **Model**: pure and framework-free where possible; validation lives in one schema reused by form and API client.
- A feature never imports another feature's internals; talk through `shared/` or a public index.
- Server state goes through one data-fetching layer; do not copy it into local state.
- Every ViewModel, repository, schema, composable/hook and component has a test; critical journeys get an end-to-end test.
- Forms: validate with the schema; show field errors next to the field; disable submit while pending.

## Checkable
- `ui/` files import no repository and no HTTP client.
- No `any`; no business rule in a template.
- Package manager: `{{PACKAGE_MANAGER}}` only.

Good: `PaymentView` calls `vm.pay()`; the ViewModel calls `repository.pay()`.
Bad: a component calling `fetch('/api/pay')` and computing the balance inline.
