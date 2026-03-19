# CLAUDE.md

## current state

| Chart | Chart Version | AppVersion | Image |
|-------|--------------|------------|-------|
| example | 0.1.0 | 1.16.0 | nginx:latest |
| go-api | 0.1.1 | 1.16.0 | ghcr.io/luciocarvalhojr/go-api:1.4.1 |
| auth-svc | 0.1.2 | *(empty)* | ghcr.io/luciocarvalhojr/observatory-auth-svc:1.5.4 |
| observatory-auth-svc | 0.1.3 | 1.6.0 | ghcr.io/luciocarvalhojr/observatory-auth-svc:1.6.0 |
| observatory-bot | 0.1.0 | 0.1.0 | ghcr.io/luciocarvalhojr/observatory-bot:0.1.0 |

**Pipeline**: GitHub Actions (`.github/workflows/release.yml`) — lint via `ct lint`, install via KinD cluster on PRs/main, release via `chart-releaser` on main push.

**Deployed**: Charts published as GitHub Releases; `index.yaml` on `main` branch serves as the Helm repo index.

`example`, `go-api`, `auth-svc`, `observatory-auth-svc` are **excluded from ct lint/install** (`ct.yaml`). `observatory-bot` is NOT excluded (actively in development, untracked).

## in progress

- **Branch `feat/pre-commit`** — adding pre-commit hooks (`trailing-whitespace`, `end-of-file-fixer`, `check-merge-conflict`, `detect-private-key`, `no-commit-to-branch`, `helm-docs`, `helmlint`) and auto-generated chart READMEs via helm-docs.
- **Branch `feat/enable-dependabot`** — expanding Dependabot config to cover additional charts.
- **Branch `feat/observatory-auth-svc`** — work on the `observatory-auth-svc` chart (already bumped to 0.1.3/1.6.0 on main).
- **`charts/observatory-bot/`** — new Telegram bot chart; untracked, has `Chart.yaml`, `values.yaml`, and an empty `templates/` directory — non-functional, not yet committed.

## known issues

- `auth-svc` has empty `appVersion` in `Chart.yaml` despite having an explicit image tag (`1.5.4`). (`observatory-auth-svc` is now fixed at `1.6.0`.)
- `observatory-bot` templates directory is empty — chart is non-functional and not yet committed.
- 4 established charts are excluded from `ct` validation — exclusion is temporary but not tracked.
- Dependabot config is incomplete: `observatory-auth-svc` and `observatory-bot` are not included.
- `auth-svc` and `observatory-auth-svc` appear to be duplicates (same image, diverging versions) — the distinction or migration plan is unclear.

## next steps

- Add Kubernetes templates to `observatory-bot` chart and commit it.
- Re-enable existing charts in `ct.yaml` once pre-commit setup is stable.
- Fix empty `appVersion` in `auth-svc`.
- Clarify or consolidate `auth-svc` vs `observatory-auth-svc` (appears redundant).
- Add `observatory-auth-svc` and `observatory-bot` to Dependabot config (merge `feat/enable-dependabot`).
- Merge `feat/pre-commit` and `feat/observatory-auth-svc` into `main`.

## key decisions

- **Monorepo**: All charts in a single repo under `charts/`, released together via chart-releaser.
- **GitHub Pages via main branch**: `index.yaml` lives on `main` (not `gh-pages`), configured in `cr.yaml`.
- **Documentation via helm-docs**: Chart READMEs are auto-generated from `values.yaml` annotations — do not edit manually.
- **Two-tier linting**: pre-commit (local, `helmlint`) + CI (`ct lint`), both enforced.
- **No commit to main**: enforced via pre-commit `no-commit-to-branch` hook — all changes via PRs.
- **Image registry**: All custom images on GHCR (`ghcr.io/luciocarvalhojr/`).
- **Security defaults**: auth-svc charts use non-root user, read-only filesystem, dropped capabilities.
