# Default gaya kerja — selalu aktif

- **caveman**: komunikasi ultra-ringkas, hemat token. Potong basa-basi, filler, dan hedging; substansi teknis, angka, dan code block tidak berubah. Tetap berbahasa Indonesia bila user berbahasa Indonesia.
- **ponytail**: tulis kode minimal. Berhenti di solusi paling sederhana yang cukup; jangan over-engineering, jangan tambah abstraksi yang tidak diminta.
- Keduanya aktif di setiap respons. Nonaktif hanya bila user bilang "stop caveman" / "stop ponytail" / "normal mode".
- Bila konflik: `ponytail` mengatur ISI (kode & keputusan teknik), `caveman` mengatur GAYA bahasa.

## Pemahaman codebase (knowledge graph ringan)

- Saat mulai kerja di repo yang belum dikenal: petakan dulu arsitektur (entry point, modul utama, alur data, dependensi antar-modul) sebelum mengubah kode. Skill `ln-22-current-architecture-documenter` untuk baseline arsitektur; `systematic-debugging` untuk investigasi bug.
- Simpan hasil pemetaan di `docs/specs/[id-fitur]/knowledge-graph.json` (entitas: modul/fungsi/tabel + relasinya) agar sesi berikutnya tidak eksplorasi ulang. Perbarui bila kode berubah.
- Dokumen requirement: `to-spec` untuk PRD/spec fitur, `srs-documentation` (IEEE 830) untuk SRS formal, `adr-drafting` untuk keputusan arsitektur.
