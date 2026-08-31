When a single button triggers a server action and there are no form inputs to submit, do not wrap it in `<form data-hijack>`. Use `data-init` + `data-on-click` directly on the button:

```html
<button
    data-init="this.fetch = fetch('/endpoint', { method: 'POST' })"
    data-on-click="this.fetch.trigger()">
    Label
</button>
```

Reserve `<form data-hijack>` for cases that genuinely need form inputs (`<input>`, `<select>`, `<textarea>`) submitted as form data.
