---
name: skill-router
description: >
  Router katalog skill Command Code. Pakai saat ragu skill mana yang cocok untuk
  sebuah task, saat user bertanya "skill apa saja yang ada", atau sebelum memulai
  pekerjaan besar (planning, implement, review, debug, docs, UI, infra).
argument-hint: "[intent atau task]"
---

# Skill Router

Peta katalog skill yang terpasang di mesin ini. Tujuan: pilih skill dengan tepat, jangan improvise.

## Cara pakai

1. Cocokkan intent ke satu baris tabel. Pilih **satu primary**; tambah maksimal **satu** pendukung.
2. Baca `SKILL.md` skill terpilih sebelum mengklaim apa isinya atau melewati langkahnya.
3. Panggil dengan `activate_skill` atau `/skill:<name>`. Skill bertanda `†` manual-only: jangan auto-run, sarankan ke user.
4. Tidak ada yang cocok → kerjakan langsung, jangan memaksakan skill.
5. Katalog penuh per kategori ada di [references/catalog.md](references/catalog.md).

## Tabel intent

| Intent | Skill |
|---|---|
| Fitur / behavior baru | `tdd`, `test-driven-development`, `incremental-implementation` |
| Review diff / PR | `code-review`, `code-review-and-quality`, `requesting-code-review`, `receiving-code-review` |
| Refactor / sederhanakan | `code-simplification`, `improve-codebase-architecture`†, `migrate-to-shoehorn` |
| Debug | `diagnosing-bugs`, `systematic-debugging`, `debugging-and-error-recovery`, `diagnose-crash` |
| Rencana / spec | `brainstorming`, `idea-refine`, `interview-me`, `planning-and-task-breakdown`, `writing-plans`, `executing-plans`, `spec-driven-development`, `srs-documentation`, `adr-drafting`, `documentation-and-adrs` |
| Git / PR | `pr`, `git-workflow-and-versioning`, `finishing-a-development-branch`, `using-git-worktrees`, `git-guardrails-claude-code`, `setup-pre-commit`, `changelog-generator` |
| Orkestrasi agent | `subagent-driven-development`, `dispatching-parallel-agents`, `context-engineering`, `using-superpowers`, `using-agent-skills` |
| Bikin / kelola skill | `skill-creator`, `writing-skills`, `skill-share`, `find-skills`, `template-skill`, bundled `skill-builder` |
| UI / frontend | `frontend-design`, `frontend-ui-engineering`, `ui-styling`, `ui-ux-pro-max`, `design-system`, `web-design-guidelines`, `vercel-react-best-practices`, `impeccable`, `antislop` + varian, `canvas-design`, `theme-factory` |
| Browser / E2E | `playwright-cli`, `playwright-best-practices`, `webapp-testing`, `browser-use`, `browser-testing-with-devtools`, `remote-browser` |
| Visual asset | `banner-design`, `brand`, `brand-guidelines`, `slides`, `artifacts-builder`, `image-enhancer`, `slack-gif-creator` |
| Infra / CI | `cloud`, `ci-cd-and-automation`, `shipping-and-launch`, `observability-and-instrumentation`, `performance-optimization` |
| Security | `security-and-hardening`, `x402` |
| API / integrasi | `api-and-interface-design`, `mcp-builder`, `connect`, `connect-apps`, `deprecation-and-migration` |
| Dokumen | `pdf`, `docx`, `xlsx` |
| Riset / konten | `research`, `content-research-writer`, `internal-comms`, `meeting-insights-analyzer`, `lead-research-assistant`, `competitive-ads-extractor`, `twitter-algorithm-optimizer`, `youtube-downloader`, `langsmith-fetch`, `developer-growth-analysis`, `tailored-resume-generator`, `raffle-winner-picker`, `file-organizer`, `invoice-organizer` |
| Pahami codebase | `understand` + `understand-chat/dashboard/diff/domain/explain/figma/knowledge/onboard`, `ln-22-current-architecture-documenter`, `codebase-design` |
| Gaya jawaban / scope | `caveman` (voice terse), `ponytail` (smallest change) |
| OS / lokal | `omarchy`, `omarchy-app`, `wizard`, `qa`, `prototype` |

## Alur besar (Matt Pocock)

`grill-with-docs`† → `to-spec`† → `to-tickets`† → `implement`† / `implement-spec`† → `code-review` → `retro`†

- `grilling` adalah primitive interview yang dipakai skill di atas; auto-invocable.
- `ask-matt`† adalah router manusianya, bukan untuk model.
- Jangan lompat ke `implement` sebelum spec jelas; user memanggil skill manual itu sendiri.

## Catatan

- `/design` mengarah ke skill user `design` (`~/.agents/skills`), bukan bundled.
- Bundled yang selalu ada: `agent-browser`, `command-code-knowledge`, `config`, `loop`, `mod-builder`, `skill-builder`.
- Jangan menyebut skill yang tidak ada di tabel ini atau di `references/catalog.md` tanpa membaca `SKILL.md`-nya.
