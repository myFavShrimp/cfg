---
name: dla
description: Direct Layers Architecture (DLA)
---

# Direct Layers Architecture

*(shown with examples in Rust)*

The workspace is layered. Each crate depends directly on the layer below it and calls that layer's functions.

```
app ─────┐
├─▶ api ─┤
└─▶ cli ─┴─▶ domain ──▶ db
```

Modules inside crates follow the same pattern, where each module can have submodules that either address different concerns needed for the current module, or are one abstraction layer below it. A different concerns for an `api` crate could be:

- crate::auth
- crate::handlers

Where `auth` would define a middleware that calls a use case for jwt extraction, and `handlers` defines all the routes.

Middlewares are NOT a concerns themselves. As this example shows, "auth" is the concern. Another example that shows the same for errors:

- Each module defines its own errors or uses errors of called functions.
- If generics are provided, like a generic error reporting structure, the error reporting itself is the concern.

If another language is used that supports Rust-like project/file/module trees, they should be used.

## Layers and Crates

- **app**: the binary with `main`. It reads config, creates the `PgPool`, installs the tracing subscriber and starts api or cli. It may call domain directly for initialization, shutdown and other logic the binary itself needs.
- **interface (api/cli/etc.)**: axum handlers, cli parsing and entry points, etc. A handler turns the request into use-case input, calls the use case and turns the result into an api response. Each kind is a separate crate (cli crate, api crate, etc.)
- **domain**: use cases and domain objects. It holds all business logic, including transaction boundaries and retries. It depends on db, because SQL filters, ordering and constraints are part of the business logic.
- **data (db/api clients/etc.)**: one function per query/request/operation, plus the row types those queries return.

Dependencies point downward.

## Types

Each layer defines its own types and returns them:

- **db** returns structs read straight from the queries.
- **domain** uses db types directly or maps them into domain types when needed. It returns domain types.
- **interface** returns api/cli/etc. types.

Conversions are `From` or `TryFrom` impls in the crate that receives the data. Value types used in queries, such as status enums and id newtypes that derive `sqlx::Type`, live in db.

In general, where possible without too big of an overhead in implementation, use newtypes.

Newtypes can also be used as abstraction on each layer. For example, in a file host application that needs to scope root storage paths for each user, a scoped root path could be a separate type that enforces the scoping, and can be extended by path slices (for path traversal) but disallows climbing into the parent of the scoped root. 

## Reusability

Things may not be shared if they don't overlap conceptually. Technical overlap doesn't justify reuse.

For example, db query functions may be domain-/use case-specific. Use case specific queries may not be reused for other use cases. But a function like reading a specific user can be shared, because it will always be conceptually the same.

Use cases are not allowed to call other use cases. They are domain entry points and only the interface layer and app are allowed to call them. A use case never triggers another entry point.

Logic in domain, that can be shared by the above rules, can be taken out of use cases and put into separate functions. For example verifying TOTP tokens.

## db functions

- Each function runs exactly one query.
- Each function takes `impl PgExecutor<'_>`, so it runs on `&PgPool` or on a transaction's connection. Code inside a transaction passes `&mut *conn`.
- Expected outcomes are in the `Ok` value: `Option` for a row that may be missing, and a `bool` from `rows_affected` for an optimistic update.

## Transactions

Use cases open transactions where it makes sense from a business logic perspective. This can be right at the top of a use case but also later after some queries or other transactions already happened.

## Errors

Every function in every layer has its own error type, defined right above or next to the function.

`thiserror` is used for errors. Messages do not include data of source errors. Every error type is distinct, so each `#[from]` has exactly one source type. `?` converts each step's error into its variant, and the variant name records which step failed. Dependency errors such as `sqlx::Error` are nested directly as the source.

Interface layer logs unexpected failures once if necessary. Expected outcomes such as not found or conflict become responses directly.

## Frontend

Frontend takes kinda a special place in this architecture. We only address server-side rendered HTML frontend, that is rendered in the same application in this architecture. Other kinds of frontend should be considered separately. A frontend itself could also use the same DL-Architecture, the patterns described below, or something entirely different.

If the frontend is part of the same application however, it uses MVVM. It is considered a separate part. Imagine a crate structure similar to the one from the top of this document.

```
app
└─▶ web ──▶ domain ──▶ db
     |
     ▼
  frontend
```

The web depends on the frontend and nothing else does. Frontend just exposes things the web needs to build the HTML for responses.

Only View and ViewModel are implemented for the frontend. The Rest of the application (`web` crate and downwards) is considered the model.
