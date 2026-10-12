# Eval routing skill (regression set)

Jalankan ulang tiap AGENTS.md / skill berubah. Untuk tiap prompt, catat:
klasifikasi (kecil/menengah/besar) + skill yang di-load + plan/tidak.
Lolos bila sama dengan ekspektasi. Tanpa eksekusi beneran (klasifikasi saja),
kecuali E-01 yang read-only aman.

## E-01 kecil — jelaskan file
Prompt: `jelaskan bagian Skill routing di ~/.config/opencode/AGENTS.md`
Ekspektasi: kecil → tanpa plan, tanpa skill, baca + jawab langsung.

## E-02 menengah — edit kecil
Prompt: `tambahkan contoh trigger ke tabel Skill routing di AGENTS.md global`
Ekspektasi: menengah-kecil → analisis (baca file dulu) → eksekusi langsung → verifikasi baca ulang.
Skill: tanpa skill khusus (edit konvensi). Tanpa plan.

## E-03 besar — fitur dari nol
Prompt: `bangun sinkron 2-arah skill opencode ↔ antigravity dengan deteksi konflik`
Ekspektasi: besar → `writing-plans` → plan + acceptance criteria → STOP, minta review.
Tanpa kode sebelum plan disetujui.

## E-04 browser — testing web
Prompt: `tes webapp lokal di ~/proyek: klik tombol bayar, screenshot hasilnya`
Ekspektasi: `webapp-testing`. BUKAN `browser-use` / `playwright-cli` (bin tidak ada).

## E-05 UI — baru vs review
Prompt A: `buatkan landing page warung kopi, mobile-first`
Ekspektasi A: `frontend-design` (+ `antislop` sebagai constraint). BUKAN `ui-ux-pro-max` sebagai utama.
Prompt B: `review aksesibilitas halaman checkout ini [file]`
Ekspektasi B: `web-design-guidelines`. BUKAN `ui-ux-pro-max`.

## E-06 dokumen — SRS
Prompt: `buatkan SRS untuk fitur keranjang belanja`
Ekspektasi: `srs-documentation` (+ `brainstorming` bila ambigu). BUKAN `to-spec` (tracker belum setup).

## E-08 debug — error acak
Prompt: `API Go mengembalikan 500 acak setelah perubahan terakhir. Telusuri akar masalah, reproduksi, perbaiki, verifikasi.`
Ekspektasi: menengah, `systematic-debugging`, tanpa plan awal (plan hanya bila investigasi meluas lintas komponen).

## E-09 plan — reset password
Prompt: `Buat rencana implementasi fitur reset password, dari endpoint sampai pengujian, tanpa mengubah kode dulu.`
Ekspektasi: menengah, `writing-plans`, plan: ya, stop sebelum kode.

## E-10 review — diff PR
Prompt: `Review diff PR ini. Fokus bug, regresi, keamanan, jangan perbaiki.`
Ekspektasi: menengah, `code-review-and-quality` (standalone; BUKAN `code-review` karena butuh tracker setup), tanpa plan.

## E-11 interview — intent belum jelas
Prompt: `buatkan dashboard penjualan`
Ekspektasi: kecil, `interview-me` dulu (tanpa who/why/success → gali intent satu pertanyaan per giliran). Tanpa plan/kode. BUKAN langsung `brainstorming`.

## E-12 UI — bangun dashboard
Prompt: `Implementasikan halaman dashboard admin responsif: hierarki visual jelas + state loading, empty, error.`
Ekspektasi: menengah, `frontend-ui-engineering` (bangun produksi; BUKAN `frontend-design` karena ini implementasi bukan arah estetik), `antislop` sebagai constraint.

## E-13 browser — e2e order
Prompt: `Buat tes e2e: login, buat pesanan, verifikasi status, cek riwayat.`
Ekspektasi: menengah, `webapp-testing` (satu alur lokal). BUKAN `playwright-cli`/`qa`. Tanpa plan formal.

## E-14 understand — dokumentasi arsitektur
Prompt: `Dokumentasikan arsitektur repo ini: entry point, batas modul, aliran data. Jangan ubah kode.`
Ekspektasi: menengah, `ln-22-current-architecture-documenter`. BUKAN famili `understand-*` (infra `.ua/` berat). Tanpa plan.

## E-15 handoff — serah terima
Prompt: `Siapkan handoff: pekerjaan selesai, keputusan teknis, file berubah, masalah terbuka, langkah lanjut.`
Ekspektasi: kecil, `handoff` (dokumen). BUKAN `claude-handoff` (tanpa peluncuran background agent). Tanpa plan.

## Log hasil

| Tanggal | E-01 | E-02 | E-03 | E-04 | E-05A | E-05B | E-06 | Catatan |
|---|---|---|---|---|---|---|---|---|
| 2026-10-12 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | baseline pasca-prioritas overlap |
| 2026-10-12 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | pasca-install 108 skill (upstream menang; TDD upstream, webapp-testing script berubah); varian baru dikalahkan aturan routing |

| Tanggal | E-08 | E-09 | E-10 | E-11 | E-12 | E-13 | E-14 | E-15 | Catatan |
|---|---|---|---|---|---|---|---|---|---|
| 2026-10-12 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | pin presisi v2 (deviasi: E-12 → frontend-ui-engineering bukan frontend-design GPT, karena prompt-nya implementasi); deny youtube-downloader terverifikasi perilaku via `opencode run` → BLOCKED |
| 2026-10-12 | — | — | — | — | — | — | — | — | ronde GPT-2: deny tetap (tahan update), graphify SKIP (archify cukup), tracker-setup tunda per-repo, avoid-list 4 skill masuk mirror (Antigravity tanpa deny resmi) |
