# AGENTS.md

Bare repo (`~/.dotfiles`, work-tree `$HOME`). Track hand-picked files only.

## Layout

- `.config/hypr/*.lua`, `hyprsunset.conf`, `xdph.conf` (skip `bindings.conf` + `keybindings-editor/` = generated).
- `.config/omarchy/defaults/agent`, `shell.toml`, `extensions/*.jsonc` only. Skip `branding/`, `hooks/`, `plugins/`, `shell.json`, `themed/`, `themes/`.
- Basic: `.config/mise/config.toml`, `.config/starship.toml`, `.config/git/config`.
- Root: `README.md`, `AGENTS.md`, `pkglist-*.txt`, `.dotfiles-exclude`.

## Rules

- Satu file per `dotfiles add <path>`. Larang `add -A`.
- Jangan track secrets: `.ssh/`, `.config/gh/hosts.yml`, `*.credentials.json`, `.cache`, token apapun. Auth via `gh auth login`.
- Commit: Conventional Commits (`feat:`, `fix:`, `chore:`, `docs:`).
- JANGAN pernah tambah trailer `Co-authored-by` atas nama bot/agent (CommandCodeBot, Claude, Copilot, dll) — GitHub menghitungnya sebagai contributor. Commit hanya atas nama user.
- `.bashrc`/`.zshrc` out of scope (user-owned, jangan ubah).
