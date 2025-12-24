# Logging (from https://loggingsucks.com/)

## Goal

Make logs **queryable, high-signal, and diagnostic** by logging **structured, context-rich events** (not text streams).

## What to implement in code

- **One "wide event" per request / job / command**
  - Prefer a single event that summarizes the whole execution over dozens of scattered lines.
  - The event should be usable for dashboards + troubleshooting without needing other logs.

- **Structured logging only**
  - Output JSON (or equivalent) with **stable field names**.
  - Avoid free-form strings as the main payload (keep a short `message` only as a human hint).

- **Always include execution context (required fields)**
  - Correlation: `trace_id`, `span_id` (if available), `request_id`
  - Identity / routing: `service`, `env`, `version` (git sha), `region`/`zone`
  - Request/operation: `operation`, `method`, `route` (template, not raw URL), `idempotency_key` (if used)
  - Outcome: `status`/`result`, `error.type`, `error.code`, `error.message` (sanitized), `retryable` (bool)
  - Timing: `duration_ms` (+ optionally breakdown fields: `db_ms`, `http_ms`, `queue_ms`)
  - Resources (optional but useful): `cpu_ms`, `mem_mb`, `retries`, `attempt`

- **Add minimal business context (only what helps debugging)**
  - Examples: `tenant_id`, `user_id` (hashed if needed), `order_id`, `payment_id`, `feature_flag`, `plan_tier`
  - Keep it consistent and avoid high-cardinality junk unless it's essential.

- **Design logs for querying**
  - Every "dimension" you want to filter/group by must be a **dedicated field** (not embedded in text).
  - Use consistent naming and types (don't switch between string/int for the same field).

- **Sampling strategy**
  - Keep **100% of errors** and **slow paths** (above a latency threshold).
  - Sample the "happy path" (e.g., 1–10%) to control cost/volume.
  - If possible, sample *after* you know the outcome (tail sampling).

## Don'ts

- Don't rely on `grep`-style text searching as your debugging plan.
- Don't log PII/secrets; sanitize errors and payloads by default.
- Don't emit many tiny logs that require reconstructing context manually.
