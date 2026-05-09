---
name: Per-service env files in compose deployments
description: For multi-container compose stacks, render one env file per container — never lump all vars into a single shared dotenv
type: feedback
---

When a compose stack runs multiple containers (postgres + backend + frontend + worker, etc.), generate **one env file per container** and reference each from the matching `env_file:` block in the compose template. Don't lump all variables into a single shared dotenv.

**Example layout:**

```
services/myapp/
├── postgres.env
├── backend.env
├── frontend.env
├── worker.env
└── docker-compose.yml
```

Compose:

```yaml
services:
  postgres:
    env_file: ["{{ postgres_env_path }}"]
  backend:
    env_file: ["{{ backend_env_path }}"]
  frontend:
    env_file: ["{{ frontend_env_path }}"]
  worker:
    env_file: ["{{ worker_env_path }}"]
```

Each container only sees its own config. Secrets don't leak across boundaries (e.g. `POSTGRES_PASSWORD` shouldn't appear in the frontend's environment), and which variable belongs to which service is obvious from the file layout.
