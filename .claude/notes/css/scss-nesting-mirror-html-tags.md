---
name: SCSS nesting must mirror the HTML/template structure
description: Nest SCSS selectors to match the DOM hierarchy of the corresponding template
type: feedback
---

When writing SCSS, nest selectors to mirror the structure of the corresponding HTML/template. Flat SCSS with all classes as siblings does not reflect the actual component tree and is harder to read.

**Example:**

Template:

```html
<div class="ResultItem">
  <div class="ResultIcon"></div>
  <div class="ResultLabel">
    <span class="ResultLabelText"></span>
  </div>
</div>
```

SCSS:

```scss
.ResultItem {
  .ResultIcon { ... }

  .ResultLabel {
    .ResultLabelText { ... }
  }
}
```

Not:

```scss
.ResultItem { ... }
.ResultIcon { ... }
.ResultLabel { ... }
.ResultLabelText { ... }
```

Always look at the corresponding template before writing or editing SCSS, and nest to match.
