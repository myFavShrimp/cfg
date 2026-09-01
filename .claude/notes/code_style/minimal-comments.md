Do not add comments that describe what the code does. Variable names, function names, and the code itself already convey that.

**When a comment is appropriate:** a hidden constraint, a non-obvious workaround, or a subtle invariant that a future reader would otherwise miss. Keep it short.

**Specifically: never document the absence of a feature.** Don't write "no JSON output for this command" or "this CLI doesn't support X" — readers wouldn't assume the missing thing exists, so the comment adds zero signal.

Keep in mind that the codebase IS NOT a tutorial. The following is a bad comment, because it explains why an alternative route a beginner would chose or that was taken before was done in a different way now. Comments of this kind have no value.

```php
// The "back" destination comes from the payload: The session manages the history so
// that it survives a page reload. Without a destination, there is no handler—so
// "no back possible" should not be included as a second value alongside it.
const onBack = useMemo(
    () => previousStepId === null ? null : () => setCurrentStepId(previousStepId),
    [previousStepId],
);
```
