# Comments: explain why, never how

The code says how. A comment earns its place only by saying what code cannot: the business rule, the constraint, the trap, or the trade-off.

## Write one when
- A rule or requirement drives the code: cite it (`spec §4.2`, ticket id) and give the reason.
- The code looks wrong but is deliberate (ordering, lock, rounding, workaround).
- A hidden constraint applies: concurrency, idempotency, security, data protection.
- A trade-off or rejected alternative is worth remembering.
- A known limit exists: `TODO(<trigger>): reason`.

## Do not write
- A restatement of the code (`// increment counter`).
- Banners, commented-out code, author or changelog notes (git has them).
- A docblock that only repeats types already in the signature.

## Try first
Rename, extract a well-named function, introduce a type. Comment only what remains unexplained.

Good: `// Two cashiers can pay at once; the row lock keeps receipt numbers gapless.`
Bad: `// lock the row then add one`

Comments are written in {{COMMENT_LANGUAGE}}.
