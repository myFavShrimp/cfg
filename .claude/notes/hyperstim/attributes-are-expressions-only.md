---
name: HyperStim attributes accept expressions, not statements
description: data-init, data-on-*, data-effect, data-show, etc. evaluate as JavaScript expressions — no `if`, `for`, `while`, `return`, or other statements
type: feedback
---

HyperStim data attributes are evaluated as JavaScript **expressions**, not statements. Constructs like `if`, `for`, `while`, `return`, `let`, and `const` will error at evaluation time.

**Conditional logic — use expression forms:**

```html
data-effect="condition && doThing()"
data-effect="condition ? doThing() : doOtherThing()"
data-effect="!condition || doThing()"
```

**Multiple expressions — separate with commas:**

```html
data-init="this.x = 0, this.y = 0"
```

**Avoid statements (these will error):**

```html
data-effect="if (condition) doThing()"
data-on-click="for (let i of items) ..."
```

For anything more complex than what fits in an expression, define a helper method on the component (`data-init="this.handle = () => { ... }"`) and call it from the attribute (`data-on-click="this.handle()"`).
