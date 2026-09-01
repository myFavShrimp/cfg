Prefer readable code over simpler or more performant one.

Examples:

Simple but hardly readable

```php
public function previousPageId(): ?int
{
    return array_slice($this->history(), -2, 1)[0] ?? null;
}
```

Longer, but easier to understand and follow

```php
public function previousPageId(): ?int
{
    $history = $this->history();
    $previousPageIndex = count($history) - 2;

    return $history[$previousPageIndex] ?? null;
}
```
