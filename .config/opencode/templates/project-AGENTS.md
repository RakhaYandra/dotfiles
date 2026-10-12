# [Nama Proyek] — instruksi proyek (template)

> Salin dari `~/.config/opencode/templates/project-AGENTS.md` ke root repo sebagai
> `AGENTS.md`, lalu isi bagian bertanda `[isi]`. Commit ke Git.

[Isi]: satu-dua kalimat tujuan proyek + stack utama (contoh: Go 1.27 REST API, React 19 + Vite).

## Perintah

- Build: `[isi, contoh: go build ./...]`
- Test: `[isi, contoh: go test ./...]` (wajib hijau sebelum klaim selesai)
- Lint/format: `[isi, contoh: gofmt -l . && go vet ./...]`
- Jalankan lokal: `[isi, contoh: go run ./cmd/api]`

## Struktur & konvensi

- Entry point: `[isi]`
- Modul utama: `[isi]`
- Konvensi kode: `[isi, contoh: handler tipis, logika di service, error dibungkus]`
- Hal yang dilarang: `[isi, contoh: dependensi baru tanpa izin, migrasi tanpa rollback]`

## Knowledge graph

- Default global (`docs/specs/[id-fitur]/knowledge-graph.json`) dipakai, kecuali:
- Override proyek: `[isi path bila beda, atau tulis "sama dengan default"]`

## Plan & spec

- Lokasi plan: `docs/plans/` (format skill `writing-plans`)
- Lokasi spec: `[isi, contoh: docs/specs/]`

## Skill khusus proyek

- Tambahan di luar global: `[isi, contoh: tidak ada]`
- Skill yang JANGAN dipakai di sini: `[isi, contoh: tidak ada]`
- Skill butuh tracker (`to-spec`, `implement`, `code-review`, `to-tickets`): aktif hanya setelah `/setup-matt-pocock-skills` per-repo (pakai `.scratch/` bila tanpa tracker eksternal).
