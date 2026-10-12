#!/usr/bin/env bash
# Install default AI-harness skills (global, all agents, symlinked).
# Usage: ./install-ai-skills.sh
# Re-run safely to repair missing links: npx skills update -g -y
set -euo pipefail

G=(-g -a '*' -y)
SRC_DIR="${SKILLS_SRC:-/tmp/opencode/skills-src}"
mkdir -p "$SRC_DIR"

# 'skills add' full-clone can hang/time out (>300s) on slow links.
# Fallback: shallow local clone, then add from disk. Usage: add <source> [args...]
add() {
  local src="$1"; shift
  if npx skills add "$src" "$@"; then return 0; fi
  echo "Direct add failed, retrying via shallow clone: $src" >&2
  local repo="$src" sel=()
  case "$repo" in *@*) sel=(--skill "${repo##*@}"); repo="${repo%%@*}" ;; esac
  local url="$repo"
  case "$url" in http*|git@*) ;; *) url="https://github.com/$url" ;; esac
  local name; name="$(basename "$url" .git)"
  [ -d "$SRC_DIR/$name" ] || git clone --depth 1 "$url" "$SRC_DIR/$name"
  npx skills add "$SRC_DIR/$name" "$@" "${sel[@]}"
}

# Style defaults
add https://github.com/juliusbrussee/caveman --skill caveman "${G[@]}"
add https://github.com/dietrichgebert/ponytail --skill ponytail "${G[@]}"

# Workflow superpowers penuh (upstream menang bila nama sama)
add obra/superpowers "${G[@]}"
add mattpocock/skills "${G[@]}"
add vercel-labs/skills --skill find-skills "${G[@]}"

# Koleksi tambahan 2026-10-12 (full isi, upstream menang)
add browser-use/browser-use "${G[@]}"
add nextlevelbuilder/ui-ux-pro-max-skill "${G[@]}"
add addyosmani/agent-skills "${G[@]}"
add egonex-ai/understand-anything "${G[@]}"
add composiohq/awesome-claude-skills "${G[@]}"
add tt-a1i/archify "${G[@]}"
add pbakaus/impeccable "${G[@]}"
# graphify-labs/graphify: SKIP (CLI "No skills found", archify mencukupi)

# ADHD-friendly output (tidak ter-cover koleksi di atas)
add https://github.com/ayghri/i-have-adhd --skill i-have-adhd "${G[@]}"

# Web dev + testing
add anthropics/skills "${G[@]}" -s frontend-design -s webapp-testing -s xlsx -s pdf -s docx
add vercel-labs/agent-skills "${G[@]}" -s web-design-guidelines -s vercel-react-best-practices
add microsoft/playwright-cli --skill playwright-cli "${G[@]}"
add currents-dev/playwright-best-practices-skill "${G[@]}"

# Knowledge + requirement docs
add giuseppe-trisciuoglio/developer-kit "${G[@]}" -s adr-drafting -s bug-fix-brief
add levnikolaevich/claude-code-skills@ln-22-current-architecture-documenter "${G[@]}"
add https://github.com/doubleslashse/claude-marketplace --skill srs-documentation "${G[@]}"

# Anti-slop filter (core + additive skills)
add https://github.com/miqdadbadjuber/anti-slop "${G[@]}" \
  -s antislop -s antislop-ui -s antislop-copywriting \
  -s antislop-human -s antislop-layoutmobile -s antislop-code

# The skills CLI covers most agents via ~/.agents/skills (universal).
# These file-based harnesses need explicit symlinks to the canonical dir:
SKILLS="$HOME/.agents/skills"
for s in caveman ponytail systematic-debugging brainstorming writing-plans executing-plans \
  test-driven-development verification-before-completion requesting-code-review \
  receiving-code-review finishing-a-development-branch dispatching-parallel-agents \
  subagent-driven-development using-git-worktrees writing-skills \
  find-skills code-review to-spec frontend-design \
  webapp-testing web-design-guidelines vercel-react-best-practices playwright-cli \
  playwright-best-practices adr-drafting bug-fix-brief ln-22-current-architecture-documenter \
  srs-documentation xlsx pdf docx \
  antislop antislop-ui antislop-copywriting antislop-human antislop-layoutmobile antislop-code \
  grill-me grill-with-docs improve-codebase-architecture \
  i-have-adhd browser-use ui-ux-pro-max; do
  [ -e "$SKILLS/$s" ] || { echo "SKIP (not installed): $s"; continue; }
  for d in "$HOME/.codex/skills" "$HOME/.config/opencode/skills" \
    "$HOME/.gemini/skills" "$HOME/.gemini/antigravity-cli/skills" \
    "$HOME/.copilot/skills" "$HOME/.cursor/skills"; do
    mkdir -p "$d"
    ln -sfn "$SKILLS/$s" "$d/$s"
  done
done

# Tambahan 2026-10-12 (108 skill dari 10 repo; deny 4 sampah via opencode.json permission.skill)
for s in api-and-interface-design archify artifacts-builder ask-matt banner-design brand \
  brand-guidelines browser-testing-with-devtools canvas-design changelog-generator chief-of-staff \
  ci-cd-and-automation claude-handoff cloud codebase-design code-review-and-quality code-simplification \
  competitive-ads-extractor connect connect-apps constraint-driven-development content-research-writer \
  context-engineering debugging-and-error-recovery deprecation-and-migration design design-system \
  developer-growth-analysis diagnosing-bugs diagnosing-superpowers documentation-and-adrs domain-modeling \
  domain-name-brainstormer doubt-driven-development file-organizer frontend-ui-engineering \
  git-guardrails-claude-code git-workflow-and-versioning grilling handoff idea-refine image-enhancer \
  impeccable implement implement-spec incremental-implementation internal-comms interview-me \
  invoice-organizer langsmith-fetch lead-research-assistant loop-me mcp-builder meeting-insights-analyzer \
  migrate-to-shoehorn observability-and-instrumentation open-source performance-optimization \
  planning-and-task-breakdown pr prototype qa raffle-winner-picker remote-browser research retro \
  scaffold-exercises security-and-hardening setup-matt-pocock-skills setup-pre-commit setup-ts-deep-modules \
  shipping-and-launch skill-creator skill-share slack-gif-creator slides source-driven-development \
  spec-driven-development tailored-resume-generator tdd teach template-skill theme-factory to-questionnaire \
  to-tickets triage twitter-algorithm-optimizer ui-styling understand understand-chat understand-dashboard \
  understand-diff understand-domain understand-explain understand-figma understand-knowledge understand-onboard \
  using-agent-skills using-superpowers wait-what wayfinder wizard writing-beats writing-for-agents \
  writing-fragments writing-shape x402 youtube-downloader; do
  [ -e "$SKILLS/$s" ] || { echo "SKIP (not installed): $s"; continue; }
  for d in "$HOME/.codex/skills" "$HOME/.config/opencode/skills" \
    "$HOME/.gemini/skills" "$HOME/.gemini/antigravity-cli/skills" \
    "$HOME/.copilot/skills" "$HOME/.cursor/skills"; do
    mkdir -p "$d"
    ln -sfn "$SKILLS/$s" "$d/$s"
  done
done

echo "Done. Restart opencode / open a new session in each harness."
echo "Global instruction files (tracked in dotfiles, applied automatically):"
echo "  ~/.claude/CLAUDE.md ~/.config/opencode/AGENTS.md ~/.codex/AGENTS.md ~/.gemini/GEMINI.md"
echo "  ~/.gemini/AGENTS.md ~/.config/opencode/eval-routing.md ~/.config/opencode/templates/project-AGENTS.md"
echo "Deny 4 skill sampah via ~/.config/opencode/opencode.json permission.skill (tidak di-track, ada secret)."
