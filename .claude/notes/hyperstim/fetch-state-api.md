HyperStim fetch actions expose `.state()`, which returns `'pending'` during the request and `'success'` on completion. Use this directly — don't add custom boolean flags like `clicked`, `triggered`, `completed`.

**Example:** to close a dialog after a successful POST:

```html
<button
    data-init="this.fetch = fetch('/save', { method: 'POST' })"
    data-on-click="this.fetch.trigger()"
    data-effect="this.fetch.state() === 'success' && dialog.close()">
    Save
</button>
```

Not: setting a `this.didClick = true` flag and reading it elsewhere.
