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

# Workflow core (meta-skills)
add obra/superpowers "${G[@]}" \
  -s systematic-debugging -s brainstorming \
  -s writing-plans -s executing-plans \
  -s test-driven-development -s verification-before-completion \
  -s requesting-code-review -s receiving-code-review -s finishing-a-development-branch \
  -s dispatching-parallel-agents -s subagent-driven-development \
  -s using-git-worktrees -s writing-skills
add vercel-labs/skills --skill find-skills "${G[@]}"
add mattpocock/skills@code-review "${G[@]}"
add mattpocock/skills@to-spec "${G[@]}"

# Web dev + testing
add anthropics/skills "${G[@]}" -s frontend-design -s webapp-testing -s xlsx -s pdf -s docx
add vercel-labs/agent-skills "${G[@]}" -s web-design-guidelines -s vercel-react-best-practices
add microsoft/playwright-cli --skill playwright-cli "${G[@]}"
add currents-dev/playwright-best-practices-skill "${G[@]}"

# Knowledge + requirement docs
add giuseppe-trisciuoglio/developer-kit "${G[@]}" -s adr-drafting -s bug-fix-brief
add levnikolaevich/claude-code-skills@ln-22-current-architecture-documenter "${G[@]}"
add https://github.com/doubleslashse/claude-marketplace --skill srs-documentation "${G[@]}"

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
  srs-documentation xlsx pdf docx; do
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
