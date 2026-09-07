#!/usr/bin/env bash
# Install default AI-harness skills (global, all agents, symlinked).
# Usage: ./install-ai-skills.sh
# Re-run safely to repair missing links: npx skills update -g -y
set -euo pipefail

G=(-g -a '*' -y)

# Style defaults
npx skills add https://github.com/juliusbrussee/caveman --skill caveman "${G[@]}"
npx skills add https://github.com/dietrichgebert/ponytail --skill ponytail "${G[@]}"

# Workflow core (meta-skills)
npx skills add obra/superpowers "${G[@]}" \
  -s systematic-debugging -s brainstorming \
  -s writing-plans -s executing-plans \
  -s test-driven-development -s verification-before-completion \
  -s requesting-code-review -s finishing-a-development-branch
npx skills add vercel-labs/skills --skill find-skills "${G[@]}"
npx skills add mattpocock/skills@code-review "${G[@]}"
npx skills add mattpocock/skills@to-spec "${G[@]}"

# Web dev + testing
npx skills add anthropics/skills "${G[@]}" -s frontend-design -s webapp-testing
npx skills add vercel-labs/agent-skills "${G[@]}" -s web-design-guidelines -s vercel-react-best-practices
npx skills add microsoft/playwright-cli --skill playwright-cli "${G[@]}"
npx skills add currents-dev/playwright-best-practices-skill "${G[@]}"

# Knowledge + requirement docs
npx skills add giuseppe-trisciuoglio/developer-kit "${G[@]}" -s adr-drafting -s bug-fix-brief
npx skills add levnikolaevich/claude-code-skills@ln-72-current-architecture-documenter "${G[@]}"
npx skills add https://github.com/doubleslashse/claude-marketplace --skill srs-documentation "${G[@]}"

# The skills CLI covers most agents via ~/.agents/skills (universal).
# These file-based harnesses need explicit symlinks to the canonical dir:
SKILLS="$HOME/.agents/skills"
for s in caveman ponytail systematic-debugging brainstorming writing-plans executing-plans \
  test-driven-development verification-before-completion requesting-code-review \
  finishing-a-development-branch find-skills code-review to-spec frontend-design \
  webapp-testing web-design-guidelines vercel-react-best-practices playwright-cli \
  playwright-best-practices adr-drafting bug-fix-brief ln-72-current-architecture-documenter \
  srs-documentation; do
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
