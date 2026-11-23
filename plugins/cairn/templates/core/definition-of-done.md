# Definition of done

A task is done only when every line is true:

- [ ] Behaviour works and is covered by a test written for it.
- [ ] Gates pass locally: {{GATE_COMMANDS}}
- [ ] No unrelated change slipped in; one logical change per commit.
- [ ] Memory updated in the same commit (task ticked, changelog line, `status.md` next action).
- [ ] Anything unexpected is recorded (blocker, workaround, decision).
{{PUSH_DONE_LINE}}
Say plainly what is not done. "Done except X" is a status, not a failure to hide.
