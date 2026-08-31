In HyperStim data attributes (`data-init`, `data-on-click`, `data-on-scroll`, `data-effect`, etc.), expressions must be separated by commas, not semicolons. HyperStim's expression parser uses comma as the statement separator.

**Yes:**

```html
data-init="this.x = 1, this.y = 2"
```

**No:**

```html
data-init="this.x = 1; this.y = 2"
```
