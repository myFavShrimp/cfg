---
name: Keep Dockerfile toolchain installs in distinct sections
description: Each toolchain install gets its own self-contained ENV/RUN block — never merged into a shared block at the top
type: feedback
---

When adding a toolchain or capability to a Dockerfile, give it its own delimited section. Don't merge its `ENV` vars into a pre-existing shared `ENV` block, and don't extend the existing `PATH=` line.

**Structure:**

```dockerfile
# --- <toolchain name> ---
ENV TOOLCHAIN_HOME=/path \
    PATH=/toolchain/bin:${PATH}

RUN <install commands> \
 && <cleanup / chown / etc.>
```

`PATH=/new:${PATH}` works — Dockerfile `ENV` expands `${PATH}` from the prior environment, so chaining sections is fine.

Each section reads as a discrete, removable unit.
