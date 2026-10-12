# Default gaya kerja — selalu aktif (global opencode)

- **caveman**: komunikasi ultra-ringkas, hemat token. Potong basa-basi, filler, dan hedging; substansi teknis, angka, dan code block tidak berubah. Tetap berbahasa Indonesia bila user berbahasa Indonesia.
- **ponytail**: tulis kode minimal. Berhenti di solusi paling sederhana yang cukup; jangan over-engineering, jangan tambah abstraksi yang tidak diminta.
- Keduanya aktif di setiap respons. Nonaktif hanya bila user bilang "stop caveman" / "stop ponytail" / "normal mode".
- Bila konflik: `ponytail` mengatur ISI (kode & keputusan teknik), `caveman` mengatur GAYA bahasa.

## Pemahaman codebase (knowledge graph ringan)

- Saat mulai kerja di repo yang belum dikenal: petakan dulu arsitektur (entry point, modul utama, alur data, dependensi antar-modul) sebelum mengubah kode. Skill `ln-22-current-architecture-documenter` untuk baseline arsitektur; `systematic-debugging` untuk investigasi bug.
- Simpan hasil pemetaan di `docs/specs/[id-fitur]/knowledge-graph.json` (entitas: modul/fungsi/tabel + relasinya) agar sesi berikutnya tidak eksplorasi ulang. Perbarui bila kode berubah.
- Dokumen requirement: `to-spec` untuk PRD/spec fitur, `srs-documentation` (IEEE 830) untuk SRS formal, `adr-drafting` untuk keputusan arsitektur.

## Cara kerja (klasifikasi otomatis, tanpa disuruh)

- **Kecil** (typo, label, jelaskan file/fungsi): baca konteks relevan → kerjakan → verifikasi. Tanpa plan.
- **Menengah** (endpoint, form, bug multi-komponen): periksa implementasi + dependensi → tentukan urutan → eksekusi → verifikasi.
- **Besar/ambigu** (fitur dari nol, arsitektur, refactor besar, integrasi): discovery → requirement → plan + acceptance criteria → eksekusi bertahap → verifikasi per tahap.
- Wajib: load skill relevan SEBELUM kerja (bukan sesudah). Klaim selesai hanya setelah verifikasi (baca ulang file / jalan tes / cek output).

## Skill routing (kategori → skill, muat sesuai tugas)

- Proyek baru / belum dikenal: `ln-22-current-architecture-documenter` (+ agent `explore`).
- Ide ambigu / requirement: `brainstorming`; permintaan underspecified (tanpa who/why/success) → `interview-me` dulu; uji rencana → `grill-me` (`grilling`/`loop-me`/`idea-refine` hanya eksplisit); tuang ke `srs-documentation` (`to-spec`/`implement`/`implement-spec` butuh tracker setup).
- Plan implementasi: `writing-plans`; eksekusi plan: `executing-plans` (+ disiplin `incremental-implementation`); `planning-and-task-breakdown`/`spec-driven-development` hanya bila user minta eksplisit (gated).
- Keputusan arsitektur: `adr-drafting`; audit arsitektur: `improve-codebase-architecture`.
- Implementasi: ikuti pola proyek yang ada (tanpa skill khusus bila cukup).
- Bug/error: `systematic-debugging`; bug sulit/regresi perf yang butuh feedback loop → `diagnosing-bugs`; crash/segfault: `diagnose-crash`; dokumentasikan perbaikan: `bug-fix-brief`.
- Testing: `test-driven-development` + `verification-before-completion`; testing web: `webapp-testing` (+ `playwright-best-practices` bila flaky).
- Review: `code-review-and-quality` (standalone); `code-review` (+ `requesting-`/`receiving-`) hanya bila issue tracker terkonfigurasi. Keputusan high-stakes (auth, migrasi, ireversibel) → `doubt-driven-development`.
- Selesai/rilis: `finishing-a-development-branch`.
- UI baru: bangun produksi → `frontend-ui-engineering`; arah estetik → `frontend-design`; stack shadcn/Tailwind → `ui-styling`; brand/logo/slide → `design`; `impeccable` hanya eksplisit (berat). Cek: `web-design-guidelines`; data: `ui-ux-pro-max`; constraint: `antislop-ui`.
- Paham repo: arsitektur → `ln-22-current-architecture-documenter`; knowledge-graph infra (`.ua/`) → famili `understand-*` hanya eksplisit; deep-dive file/fungsi → baca langsung (atau `understand-explain` bila graf sudah ada).
- Handoff: dokumen serah-terima → `handoff`; lanjutkan via background agent → `claude-handoff`.
- Multi-task independen: `dispatching-parallel-agents`, `subagent-driven-development`; isolasi via `using-git-worktrees`.
- Dokumen: `to-spec`, `docx`, `pdf`, `xlsx`.
- Skill teknologi spesifik (Go/Laravel/dll): belum ada — ikuti konvensi repo; tambah skill baru hanya bila kebutuhan berulang.

## Prioritas skill overlap (bila deskripsi bertabrakan, menang yang ini)

- Browser/testing web: default `webapp-testing`. `playwright-cli` untuk otomasi browser ad-hoc (bin ada). `browser-use`/`remote-browser`/`qa` hanya eksplisit (butuh cloud/bin); `browser-testing-with-devtools` hanya bila MCP chrome-devtools terkonfigurasi; `qa` khusus permintaan skor kualitas situs.
- UI: baru/desain ulang → `frontend-design`; review/audit existing → `web-design-guidelines`; cari data (font, palet, ikon) → `ui-ux-pro-max`; `antislop` (+`antislop-ui` dkk) selalu jadi constraint, bukan alternatif.
- Dokumen requirement: default `brainstorming` + `srs-documentation`; `to-spec` hanya bila issue tracker sudah terkonfigurasi (butuh setup eksternal).
- Pasca-install massal (108 skill baru, 2026-10-12): nama di tabel routing menang atas varian baru (`test-driven-development` bukan `tdd`, `writing-plans` bukan `planning-and-task-breakdown`, `executing-plans` bukan `implement`, `code-review` bukan `code-review-and-quality`, `systematic-debugging` bukan `debugging-and-error-recovery`/`diagnosing-bugs`). Varian baru hanya bila user minta eksplisit.

### Meta-router fallback

Meta-router (`using-superpowers`, `using-agent-skills`, `ask-matt`) hanya boleh dipanggil bila:
1. User minta eksplisit pemilihan skill / analisis routing; ATAU
2. Task lintas minimal 3 domain berbeda, tak ada aturan routing yang menunjuk pemenang jelas, dan tak ada trigger skill spesifik yang menyelesaikan ambiguitas.

Sebelum memanggil, tulis tepat satu baris:
`Ambiguitas: <domain A> + <domain B> + <domain C>; <keputusan yang belum bisa ditentukan>.`

Meta-router wajib: pilih SATU skill utama; tambah skill lain hanya untuk subtugas eksplisit yang berbeda; tidak pernah load semua skill untuk perbandingan; tidak pernah override pemenang routing tanpa pengecualian terdokumentasi/permintaan user; tidak rekursif.
Klarifikasi rutin, task kecil, dan kategori yang sudah ada di tabel TIDAK boleh memicu meta-router.

## Proyek baru (tanya dulu)

- Task pertama di repo tanpa `AGENTS.md` di root: TAWARKAN scaffold dulu, jangan langsung kerja.
- Bila user setuju: salin `~/.config/opencode/templates/project-AGENTS.md` ke root repo, isi dari hasil discovery (`ln-22-current-architecture-documenter` + agent `explore`), minta koreksi user, commit bila diminta.
- Bila user tolak: lanjut kerja seperti biasa, jangan tawarkan lagi di sesi itu.
