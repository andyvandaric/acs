# Panduan Quick Start - Aktivasi Full Private Stack

Mulai cepat, setup bersih, dan aktifkan workflow private dalam hitungan menit.

> **Catatan:** Ini repositori private. Kamu perlu akses yang sudah di-approve sebelum install.
> Hubungi pemilik repo https://wa.me/6281289731212?text=Mau%20order%20OCS%20nya%2C%20mohon%20infonya%20ya untuk mendapatkan undangan dan membuka full private setup.

## Daftar Isi

- [Panduan Quick Start - Aktivasi Full Private Stack](#panduan-quick-start---aktivasi-full-private-stack)
  - [Daftar Isi](#daftar-isi)
  - [Prasyarat](#prasyarat)
  - [Install](#install)
    - [Langkah 1 — Verifikasi akses private](#langkah-1--verifikasi-akses-private)
    - [Langkah 2 — Jalankan installer](#langkah-2--jalankan-installer)
  - [Setelah instalasi](#setelah-instalasi)
    - [Langkah 3 — Login ke runtime](#langkah-3--login-ke-runtime)
    - [Langkah 4 — Konfigurasi profile global suite](#langkah-4--konfigurasi-profile-global-suite)
    - [Langkah 5 — Adaptive skills + ekstensi rules/workflow kustom](#langkah-5--adaptive-skills--ekstensi-rulesworkflow-kustom)
    - [Langkah 6 — Pakai OpenCode VSCode Extension by SST (Rekomendasi)](#langkah-6--pakai-opencode-vscode-extension-by-sst-rekomendasi)
    - [🌐 Opsi kedua: Web UI](#-opsi-kedua-web-ui)
    - [Cek kuota akun](#cek-kuota-akun)
    - [Teknis mengamankan akun Gemini Pro](#teknis-mengamankan-akun-gemini-pro)
    - [Setup akun Google baru: enable API Gemini Pro/Ultra](#setup-akun-google-baru-enable-api-gemini-proultra)
  - [Menambahkan Banyak Akun (Cara Aman)](#menambahkan-banyak-akun-cara-aman)
    - [Langkah-langkah](#langkah-langkah)
    - [Kendala akun: `[needs verification]` atau `[disabled]`](#kendala-akun-needs-verification-atau-disabled)
    - [Ringkasan](#ringkasan)
    - [Workaround pemilihan akun (mode aman)](#workaround-pemilihan-akun-mode-aman)
    - [FAQ cepat: disable/ganti akun/limit](#faq-cepat-disableganti-akunlimit)
  - [Memilih Profile](#memilih-profile)
    - [Mode Resource (low / balanced / performance)](#mode-resource-low--balanced--performance)
    - [Matriks Pilih Cepat](#matriks-pilih-cepat)
    - [Decision Tree Pilih Profile](#decision-tree-pilih-profile)
    - [Memilih Mode Agent (Sisyphus, Hephaestus, Prometheus, Atlas)](#memilih-mode-agent-sisyphus-hephaestus-prometheus-atlas)
    - [Setelah ganti profile (penting)](#setelah-ganti-profile-penting)
  - [Update ke Versi Terbaru](#update-ke-versi-terbaru)
  - [Plugin Stack](#plugin-stack)
    - [Dynamic Context Pruning (DCP)](#dynamic-context-pruning-dcp)
    - [Safety Net (`cc-safety-net`)](#safety-net-cc-safety-net)
    - [Plugin Opsional](#plugin-opsional)
      - [`@ramtinj95/opencode-tokenscope` — Analitik Token \& Biaya](#ramtinj95opencode-tokenscope--analitik-token--biaya)
  - [Troubleshooting](#troubleshooting)

---

## Prasyarat

Mulai dari **download dan install GitHub CLI** dulu:

- **Windows**: [https://cli.github.com/](https://cli.github.com/) atau `winget install --id GitHub.cli -e`
- **macOS**: `brew install gh`
- **Linux**: [https://cli.github.com/](https://cli.github.com/)

Prasyarat tambahan yang wajib diperhatikan:

- **Windows**: wajib install **PowerShell 7** sebelum menjalankan `install.ps1`.
  Panduan resmi: [Install PowerShell on Windows](https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6)
- **macOS**: terminal default **zsh** didukung. Kalau kamu sengaja menjalankan installer dari legacy `/bin/bash` lalu bootstrap Bun gagal, update Bash atau install Bun manual dulu.

Setelah GitHub CLI terpasang, login sekali untuk membuka akses repo private.
Pilih **HTTPS** saat diminta, lalu selesaikan **OAuth device verification**:

```bash
gh auth login -h github.com -w
```

---

## Install

### Langkah 1 — Verifikasi akses private

```bash
gh repo view andyvandaric/andyvand-opencode-config
```

Kalau `gh repo view` gagal, berarti akun GitHub yang sedang aktif belum punya akses ke repo private. Login ulang dengan akun yang sudah diundang, lalu ulangi:

```bash
gh auth login -h github.com -w
```

### Langkah 2 — Jalankan installer


Untuk sesi kerja panjang, jalur paling stabil adalah **OpenCode VSCode Extension by SST** karena runtime mengikuti lifecycle proses VS Code.

**Windows (PowerShell):**

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex"
```

Install versi tertentu:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command '$env:OCS_VERSION = "3.0.0"; irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex'
```

**Linux / macOS (Bash):**

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.sh | bash
```

Install versi tertentu:

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.sh | bash -s -- --version 3.0.0
```

Installer otomatis akan:

- Menginstal **Git**, **Bun**, dan **GitHub CLI** bila belum ada
- Menjalankan deployment konfigurasi OCS
- Menginstal **OpenCode CLI**
- Menginstal/memperbaiki helper kompresi native, termasuk shim `grep.exe` OCS-managed di `.opencode/bin` yang dibutuhkan `rtk grep` pada Windows
- Menginstal **CocoIndex** (via Python/pip), menulis `~/.config/opencode/cocoindex/.env`, dan menyiapkan `postgres.compose.yml` untuk bootstrap lokal

---

## Setelah instalasi

### Langkah 3 — Login ke runtime

```bash
opencode auth login
```

_(Path default yang direkomendasikan: **OpenAI -> Chatgpt browser**. Bisa juga pilih Google/OpenAI lain sesuai kebutuhan.)_

### Langkah 4 — Cek runtime inti

Windows (PowerShell 7):

```powershell
ocs exa setup --api-key <YOUR_EXA_API_KEY>
ocs exa check
opencode mcp list
opencode --port 78617
# kalau lebih suka web UI
opencode web --port 8089
```

macOS / Linux:

```bash
ocs exa setup --api-key <YOUR_EXA_API_KEY>
ocs exa check
opencode mcp list
opencode --port 78617
# kalau lebih suka web UI
opencode web --port 8089
```

Kalau mau ganti dari profile default ChatGPT/Codex ke profile lain, jalankan:

```bash
ocs setup:profile
```

Kalau `ocs` atau `opencode` belum terdeteksi setelah install:

```bash
export PATH="$HOME/.opencode/bin:$HOME/.local/bin:$HOME/.bun/bin:$PATH"
hash -r
ocs doctor
```

### Langkah 5 — Adaptive skills + ekstensi rules/workflow kustom

OCS otomatis membuat scaffold ekstensi milik user:

- `~/.config/opencode/extensions/README.md`
- `~/.config/opencode/extensions/skills/README.md`
- `~/.config/opencode/extensions/rulesets/README.md`
- `~/.config/opencode/extensions/workflow/README.md`

Pola kerja presisi yang direkomendasikan:

1. Biarkan baseline skill OCS tetap terkelola di `~/.config/opencode/skills`.
2. Tambahkan rules/skills/workflow kustom hanya di `~/.config/opencode/extensions/*`.
3. Terapkan adaptive minimum-sufficient loading (mulai dari baseline domain, tambah skill ekstra hanya ketika ada trigger risiko yang jelas).

Model mental built-in bundle:

- **Routing**: `frontend-ui-ux`, `ocs-parallel-orchestration-grooming`
- **Context**: `ocs-product-marketing-context`
- **Execution**: `ocs-lsp-bootstrap`, `ocs-cocoindex-bootstrap`, `ocs-technical-copy-seo`
- **Audit**: `ocs-seo-audit`
- **Verification**: `ocs-runtime-validation`, `ocs-tdd-rgr-regression-guard`, `ocs-markdown-autofix`
- **Modifier**: `impeccable-style`

Contoh kombinasi aman:

- Setup positioning produk: `ocs-product-marketing-context`
- Rewrite copy teknikal: `ocs-product-marketing-context` -> `ocs-technical-copy-seo` -> `ocs-markdown-autofix`
- Diagnosis SEO: `ocs-product-marketing-context` -> `ocs-seo-audit`
- Redesign visual atau cleanup UI: `frontend-ui-ux` -> opsional `impeccable-style`
- Bug fix perilaku atau refactor berisiko: `ocs-tdd-rgr-regression-guard` -> tambahkan `ocs-runtime-validation` hanya kalau risikonya sensitif terhadap environment
- Recovery CocoIndex: `ocs-cocoindex-bootstrap` -> `ocs-runtime-validation` kalau butuh bukti runtime final

Study case praktis:

- [Adaptive Skills Case Study (integrasi ClawSkills)](./adaptive-skills-clawskills-case-study.md)
- Termasuk template copy-paste agar user bisa minta agent menginstall + mengaktifkan skill yang tepat secara otomatis.
- Untuk dokumen/plan yang markdown-heavy, load `ocs-markdown-autofix` agar agent memprioritaskan `lint:md:fix` + `lint:md` milik repo, lalu fallback ke `bunx markdownlint-cli2`, lalu `npx markdownlint-cli2`, dan gagal dengan jelas kalau tidak ada runner yang didukung.

### Langkah 5.5 — Advanced: troubleshooting CocoIndex (khusus agent/project)

Kebanyakan user bisa mengabaikan bagian ini. CocoIndex ditujukan untuk semantic retrieval per project ketika agent atau task tertentu memang membutuhkannya. Ini bukan langkah default setelah install, dan jangan pernah diarahkan ke folder global `~/.config/opencode`.

Kalau workspace tertentu memang butuh CocoIndex dan wrapper terkelola terlihat bermasalah, pakai tangga yang didukung berikut ini.

- `ocs index status` adalah langkah pertama: pastikan server MCP terdaftar, sehat, dan siap untuk project yang sedang aktif.
- `ocs index start [--force] [--wait] [--timeout <seconds>]` menyalakan stack CocoIndex (Python, `ccc`, Postgres) yang sudah dipasang oleh setup untuk workspace itu.
- `ocs index logs --tail <lines> --follow` men-stream STDIO `ccc mcp` agar kamu bisa memantau cek dependensi, progres indexing, dan handshake jaringan. `--tail 200 --follow` tetap jadi default yang aman.
- `ocs index doctor` menjalankan pemeriksaan kesehatan dan perbaikan otomatis yang mengenal runtime `ccc`.
- `ocs index rebuild --force` membangun ulang indeks project yang sedang aktif. Tambahkan `--hard-reset` hanya kalau kamu memang mau menghapus semua file `.mdb` milik project itu dan mulai dari nol.
- `ocs index stop [--timeout <seconds>] [--force]` mematikan server MCP dengan bersih agar bisa di-restart atau di-update.

Ikuti tangga: status → start → logs → doctor → rebuild, dan hentikan layanan hanya bila kamu benar-benar hendak memulai ulang.

#### Pemulihan edge-case — profile sukses tapi model/MCP masih stale

Kalau `ocs setup profile` sukses tapi Web UI masih menampilkan routing model lama (atau MCP CocoIndex belum muncul), jalankan urutan pemulihan ini di **shell/environment yang sama** dengan tempat kamu menjalankan OpenCode:

1. Terapkan ulang profile:
   - `ocs setup profile`
2. Refresh katalog model:
   - `opencode models --refresh`
3. Rehydrate registrasi/runtime MCP CocoIndex untuk workspace yang sedang aktif:
   - `ocs index status`
   - Jika belum ada / unhealthy: `ocs index start --force --wait`
4. Restart runtime penuh (wajib):
   - Hentikan `opencode web` (`Ctrl+C`)
   - Jalankan lagi dengan port yang sama

Catatan WSL: kalau OpenCode dijalankan dari WSL, lakukan setup + refresh + launch semuanya dari WSL sebagai alur konsisten. Hindari setup di satu environment lalu runtime di environment lain.


Untuk panduan operasi CocoIndex yang lebih luas dan urutan fallback MCP saat tidak responsif, lihat [panduan operasi CocoIndex](./cocoindex-ops-id.md). Perlakukan panduan itu sebagai troubleshooting advanced untuk indexing per project, bukan langkah onboarding default.

### Langkah 6 — Pakai OpenCode VSCode Extension by SST (Rekomendasi)

1. Buka VS Code.
2. Buka tab Extensions (`Ctrl+Shift+X` / `Cmd+Shift+X`), cari **"opencode"** (Publisher: SST), lalu install.
3. Buka folder project kamu di VS Code.
4. Buka panel OpenCode di sidebar dan mulai chat.
5. Tidak perlu set API key di setting VS Code karena `opencode auth login` berlaku global.

### 🌐 Opsi kedua: Web UI

Kalau kamu butuh alur browser/multi-tab, Web UI tetap didukung penuh:

```bash
# Windows
cd %USERPROFILE%\Dev\ProyekSaya
opencode web --port 8089

# macOS / Linux
cd ~/Dev/ProyekSaya
opencode web --port 8089
```

Buka `localhost:8089`, lalu pilih folder project di UI.

> Catatan: bila kamu mengubah file konfigurasi `.json`, restart server Web UI (`Ctrl+C` lalu jalankan lagi) agar perubahan terbaca bersih.

Di Web UI, kamu bisa membuka percakapan Sub-Agent di tab terpisah (`Open in New Tab`) untuk pengawasan paralel.

### Cek kuota akun

Untuk melihat sisa kuota semua akun:

1. Jalankan `opencode auth login`
2. Pilih **Google** → **OAuth with Google (Antigravity)**
3. Pilih **Check quotas**

Akan muncul tampilan per akun berisi kuota Gemini CLI dan Antigravity (Claude, Gemini 3.1 Pro, Gemini 3 Flash) lengkap dengan progress bar dan timer reset masing-masing.

### Onboarding multi-account OpenAI (ChatGPT) — demo CLI

Gunakan alur ini untuk menambahkan dan mengelola akun OpenAI secara aman dan profesional.

#### Tambah akun ChatGPT

```bash
opencode auth login -p openai
```

Saat menu muncul:

1. Buka menu **OpenAI accounts**.
2. Pilih **ChatGPT Pro/Plus (browser)**.
3. Salin URL login yang ditampilkan CLI, lalu buka di browser profile bersih yang sudah login ChatGPT.
4. Selesaikan login dan pilih workspace yang tepat (misalnya workspace Business jika relevan).
5. Saat muncul URL redirect/fallback, salin **URL final lengkap** lalu paste kembali ke prompt CLI.
6. Tekan Enter untuk menyelesaikan proses import akun.

#### Kelola multi-account dan cek kuota

Gunakan command yang sama untuk membuka menu manajemen akun:

```bash
opencode auth login -p openai
```

- **Add account**: tambah akun ChatGPT lainnya.
- **Manage accounts**: enable/disable atau hapus akun tertentu.
- **Check quotas**: cek sisa kuota/limit semua akun OpenAI yang terdaftar.

#### Contoh sesi CLI (ilustrasi)

```text
$ opencode auth login -p openai
┌ OpenAI accounts
◆ Select an account-management action
│ ● ChatGPT Pro/Plus (browser)

[CLI menampilkan URL login]
[Buka URL di browser profile yang sudah login ChatGPT]
[Selesaikan login lalu copy URL fallback final]

Paste callback URL:
https://chat.openai.com/...<URL callback lengkap>...

✅ Account imported successfully
```

### Teknis mengamankan akun Gemini Pro

Gunakan langkah tambahan berikut untuk meningkatkan keamanan akun, tetap dalam jalur resmi dan kebijakan platform.

1. **Siapkan login Android untuk Google Command**
   - Wajib login di HP Android (Agar google command aktif). Ini nanti dibutuhkan untuk scan barcode saat akun terkena need verif

2. **Aktifkan Authenticator dari pengaturan Akun Google**
   - Masuk Setting > Kelola Akun Google > Keamanan & Login > Authenticator
   - Jika minta Pindai kode QR, klik Can't See / Tidak dapat memindainya, nanti akan muncul 32 digit code, copy saja dan simpan

3. **Gunakan 2fa.live untuk generate kode OTP**
   - Masukkan setup key 32 digit dari langkah 2 ke 2fa.live, lalu gunakan kode yang dihasilkan untuk verifikasi sebagai penganti Goggle Authenticator.
   - Jangan membagikan setup key atau backup code ke pihak lain.
     INGAT: Jangan Pakai Google Authenticator, agar tidak terdeteksi banyak akun dalam 1 device, main 2fa.live adalah solusi yg lebih aman

4. **Tambahkan email pemulihan**
   - Pastikan recovery email aktif dan bisa diakses, untuk proses recovery jika sesi terkunci.
   - Pakai email dari outlook untuk menghindari footprint google

5. **Aktifkan Verifikasi 2 Langkah (2fa) yg wajib tercentang untuk menaikkan score akun:**
   - Kunci sandi dan kunci keamanan
   - Dialog Google (otomatis saat akun sudah login hp android)
   - Authenticator sudah aktif dari langkah no2 dan 3
   - Kode cadangan, opsional tapi dianjurkan. Simpan kode backup cadangan masing2 akun di tempat aman

6. **Remove nomor telepon pemulihan biar ga repot kena phon verif**
   - Point no 1 - 5 sudah cukup ampuh selama ini untuk akun2 ternakan saya.

7. **Beri waktu stabilisasi setelah perubahan keamanan**
   - Setelah melakukan langkah2 diatas, akun diamkan dulu, jangan diapa2in dalam 12-24 jam ke depan.
   - Begitu juga setelah join di grup family, jangan langsung ditambahkan ke opencode, diamkan dulu.

8. **Gunakan Google Family Sharing dan mainkan untuk akun sub**
   - Buat yang belum tau, Google Family Sharing bisa dapet kuota sendiri2, bisa invite hingga 5 akun sub, kita mainkan itu yang dimasukkan di opencode.
   - Kunjungi:
     https://one.google.com/settings?expand=upgrade&g1_last_touchpoint=64&g1_landing_page=0&utm_source=g1&utm_medium=paid_media&utm_campaign=storage
   - Bikin family sharing, invite 5 akun google lain non pro (email lama lebih baik, pastikan telah melakukan ritual no1 - 7)
   - Nyalakan toogle "Share Google One with family" kunjungi kedua kalinya link yang saya bagikan di atas.

9. **Jaga hygiene login sesi awal**
   - Login baru wajib 1 akun 1 IP, karena google mendeteksi sesi pertama kali login. Berlaku di semua device, HP, browser chrome maupun saat menambahkan akun di opencode lewat "opencode auth login". Kasih jeda juga biar lebih aman, jangan langsung login banyak.
   - Hindari banyak login baru secara bersamaan lintas device/network.

### Setup akun Google baru: enable API Gemini Pro/Ultra

Beberapa project Google Cloud baru belum bisa pakai Gemini Pro/Ultra sebelum API wajib diaktifkan.

1. Buka Google Cloud Console (`https://console.cloud.google.com/`).
   - Buat Project baru jika belum ada, atau pilih project yang sudah ada.
   - Pastikan Anda berada di project yang benar, lalu **Copy Project ID** Anda.
2. Enable semua API wajib dengan mengganti `<projectid>` pada link di bawah ini dengan Project ID Anda yang sebenarnya (lalu klik **Enable** di masing-masing halaman):
   - **Gemini for Google Cloud API:**
     `https://console.cloud.google.com/apis/library/cloudaicompanion.googleapis.com?project=<projectid>`
   - **Vertex AI API:**
     `https://console.cloud.google.com/apis/library/aiplatform.googleapis.com?project=<projectid>`
   - **Generative Language API:**
     `https://console.cloud.google.com/apis/library/generativelanguage.googleapis.com?project=<projectid>`
3. Verifikasi status di API dashboard:
   - Buka `https://console.cloud.google.com/apis/dashboard?project=<projectid>`
   - Pastikan ketiga API tersebut sudah aktif di project yang tepat.
4. Restart sesi auth OpenCode:
   - Hentikan OpenCode yang sedang jalan (`Ctrl+C`)
   - Jalankan ulang `opencode auth login`
   - Jalankan lagi OpenCode dengan port yang sama (contoh: `opencode web --port 8089`)

Kalau masih muncul error `PERMISSION_DENIED` atau API belum aktif, tunggu 2-10 menit (delay propagasi), lalu login ulang dan coba lagi.

## Menambahkan Banyak Akun (Cara Aman)

> **Penting:** Agar akun Google-mu tetap aman, ikuti metode ini saat menambahkan banyak akun.

Setiap akun sebaiknya login dari **IP yang berbeda**. Login banyak akun dari IP yang sama secara berulang bisa memicu deteksi aktivitas mencurigakan dari Google.

### Langkah-langkah

**1. Siapkan Chrome profile terpisah**

Buat satu Chrome profile per akun:

- Buka Chrome → klik ikon profil (pojok kanan atas) → **Tambah**
- Beri nama tiap profil (misal: Akun 1, Akun 2, ...)
- Tiap profil punya cookie dan sesi sendiri — Google menganggapnya sebagai browser yang berbeda

**2. Gunakan hotspot HP (tethering)**

Sambungkan PC ke hotspot HP, bukan WiFi/LAN rumah. IP mobile bersifat dinamis dan mudah diganti.

**3. Ganti IP setiap pindah akun**

Sebelum login akun berikutnya:

1. Aktifkan **Mode Pesawat** di HP selama ~10 detik
2. Matikan Mode Pesawat — HP mendapat IP baru
3. Login akun berikutnya dengan `opencode auth login` di Chrome profile yang sesuai

> **Aturan: 1 akun = 1 IP**
> Jangan pernah login 2 akun berbeda dari IP yang sama dalam satu sesi.

### Kendala akun: `[needs verification]` atau `[disabled]`

Beberapa akun bisa muncul dengan status `[needs verification] [disabled]` di daftar akun. Artinya Google menandai akun tersebut dan tidak bisa dipakai sampai diverifikasi.

**Verifikasi via Antigravity Manager (disarankan):**

- Gunakan tool [Antigravity Manager](https://github.com/lbjlaq/Antigravity-Manager/blob/main/README_EN.md) lewat Antigravity IDE untuk mencoba verifikasi.
- Catatan: verifikasi **tidak bisa** dilakukan langsung dari dalam OpenCode — harus pakai tool eksternal tersebut.

**Kalau akun tidak bisa diverifikasi:**

1. Hapus akun yang bermasalah (`opencode auth login` → pilih akun → delete)
2. Tambahkan akun baru sebagai gantinya
3. Akun baru langsung bisa dipakai

**Kalau verifikasi berhasil lewat Antigravity IDE:**

1. Kembali ke `opencode auth login` → pilih akun yang tadi bermasalah → delete
2. Login ulang akun yang sama
3. Akun sudah bisa dipakai kembali seperti biasa

### Ringkasan

| Langkah | Tindakan                                            |
| ------- | --------------------------------------------------- |
| 1       | Buka Chrome profile khusus untuk akun ini           |
| 2       | Sambungkan PC ke hotspot HP                         |
| 3       | Airplane mode HP 10 detik → matikan (dapat IP baru) |
| 4       | Jalankan `opencode auth login` → pilih Google       |
| 5       | Ulangi dari langkah 1 untuk akun berikutnya         |

### Workaround pemilihan akun (mode aman)

Jangan biarkan hanya satu akun aktif untuk sesi panjang. Itu bisa bikin kuota cepat habis dan meningkatkan risiko `403 Forbidden`.

Cara yang lebih aman: aktifkan beberapa akun yang sehat, lalu nonaktifkan akun yang bermasalah.

1. Jalankan `opencode auth login`
2. Di menu manajemen akun:
   - akun bermasalah (rate-limit / needs verification / tidak stabil): **Disable**
   - akun sehat: **Enable** (disarankan minimal 6 akun)
3. Restart sesi OpenCode:
   - hentikan proses yang sedang jalan dengan `Ctrl+C`
   - jalankan `opencode web --port 8089` (pakai port yang sama seperti sebelumnya)

Dengan cara ini auto-rotation tetap berjalan di akun sehat, jadi kuota lebih awet dan error lebih sedikit.

Mode satu akun sebaiknya hanya dipakai sebentar untuk debugging/testing, lalu aktifkan lagi akun sehat lainnya.

### FAQ cepat: disable/ganti akun/limit

- Gimana cara disable sementara akun di `oh-my-openagent`?
  - Jalankan `opencode auth login` -> masuk manajemen akun -> set akun bermasalah ke **Disable**.
- Kapan harus ganti akun?
  - Ganti saat akun kena rate-limit, muncul `needs verification`, tidak stabil, atau sering `403` berulang.
- Limitnya patokan kapan?
  - Tidak ada angka tunggal yang berlaku untuk semua user. Cek status kuota (`Check quotas`) lalu rotasi saat akun mendekati limit.
  - Baseline operasional yang disarankan: minimal 6 akun sehat tetap **Enable** agar rotasi aman.

---

## Memilih Profile

Saat menjalankan setup (`bun run setup:profile`), kamu akan diminta memilih profile:

Butuh ganti profile cepat tanpa prompt? Jalankan:

```bash
ocs setup:profile --profile gemini-3-all --headless
```

| #   | Profile                    | Otak Utama                    | Cocok Untuk                                                                    |
| --- | -------------------------- | ----------------------------- | ------------------------------------------------------------------------------ |
| 1   | `gpt-5.4-best-perform`     | GPT 5.4 + Codex 5.3           | Rekomendasi utama harian: default kualitas tertinggi untuk task kritis.        |
| 2   | `codex-5.3-token-saver`    | Codex 5.3 + Codex 5.1 Mini    | Backup Codex-first untuk throughput harian yang lebih hemat biaya.             |
| 3   | `gpt-5.4-token-saver`      | GPT 5.4 + Codex 5.1 Mini      | Profil backup GPT dengan worker lebih hemat token.                             |
| 4   | `glm-4.7-lite-token-saver` | GLM 4.7 + family GLM campuran | Jalur mixed-strategy ringan untuk throughput hemat biaya.                      |
| 5   | `codex-5.3-hybrid`         | Codex + Gemini + Sonnet       | Strategi campuran seimbang dengan Codex sebagai lead.                          |
| 6   | `codex-5.3-all`            | GPT 5.3 Codex                 | Semua agent dan kategori pakai Codex.                                          |
| 7   | `codex-5.3-gemini`         | Codex + Gemini                | Codex-heavy: Codex orkestrasi + Gemini worker.                                 |
| 8   | `codex-5.3-sonnet-4.6`     | Codex + Sonnet 4.6            | Codex utama dengan worker Sonnet jalur kualitas.                               |
| 9   | `gemini-3-all`             | Gemini 3.1 Pro + 3 Flash      | **Gemini-only.** Cepat, tanpa penggunaan Claude.                               |
| 10  | `opus-4.6-lead`            | Opus + worker campuran        | **Lead profile.** Akurasi tertinggi untuk role kritis.                         |
| 11  | `sonnet-4.6-lead`          | Sonnet + worker campuran      | **Lead profile.** Jalur Claude-led yang seimbang.                              |
| 12  | `sonnet-4.6-all`           | Sonnet 4.6 Thinking           | **All profile.** Single-family Sonnet penuh.                                   |

**Rekomendasi mulai cepat:**

- Default harian kualitas tertinggi -> `gpt-5.4-best-perform`
- Backup Codex-first yang lebih hemat -> `codex-5.3-token-saver`
- Backup GPT yang lebih hemat worker token -> `gpt-5.4-token-saver`

### Mode Resource (low / balanced / performance)

Setelah pilih profile, setup akan minta kamu pilih mode resource. Mode ini mengontrol seberapa besar tekanan compute yang diberikan OpenCode ke mesinmu, dengan cara menyesuaikan kedalaman berpikir dan intensitas variant agent.

| Mode          | Cocok untuk                                 | Yang berubah                                                                 | Concurrent agent |
| ------------- | ------------------------------------------- | ---------------------------------------------------------------------------- | :--------------: |
| `low`         | Laptop, banyak app jalan, hemat baterai     | Agent berat diturunkan ke variant `low`/`minimal`. Worker Flash tetap cepat. | ~40% spare core  |
| `balanced`    | Coding harian, kebanyakan user (default)    | Pakai default profile apa adanya. Tidak ada override variant.                | ~80% spare core  |
| `performance` | Arsitektur, debugging berat, refactor besar | Role kritis di-upgrade ke variant `max`/`high`.                              |  spare core − 1  |

> **Pilih cepat:**
>
> - Laptop / browser + IDE terbuka → `low`
> - Kerja harian normal → `balanced`
> - Masalah sulit, task kompleks → `performance`

> **Formula concurrent agent:** `spareCores = totalCore − 2` (2 core direserve untuk OS + OpenCode). Setup menulis limit ini ke file kompatibilitas terpasang `~/.config/opencode/oh-my-opencode.json` / `oh-my-openagent.json`.

**Yang sebenarnya dilakukan mode `low`:**

| Agent / Kategori                         | Variant normal | Variant mode `low` |
| ---------------------------------------- | -------------- | ------------------ |
| `sisyphus`, `oracle`, `atlas`            | `max` / `high` | `low`              |
| `explore`, `quick`, `unspecified-low`    | `high` / none  | `minimal`          |
| `librarian`, `implementation`, `testing` | bervariasi     | `low`              |
| `deep`, `ultrabrain`                     | `max`          | `low`              |

> Kamu bisa jalankan setup kapan saja untuk ganti mode tanpa ganti profile.

### Matriks Pilih Cepat

| Use case                             | Profile                 | Kenapa                                                                   |
| ------------------------------------ | ----------------------- | ------------------------------------------------------------------------ |
| Default harian kualitas tertinggi    | `gpt-5.4-best-perform`  | GPT 5.4 jadi lead default, sementara Codex 5.3 tetap siap untuk throughput worker yang kuat. |
| Backup GPT kualitas tinggi           | `gpt-5.4-best-perform`  | GPT-5.4 untuk lane core/deep, Codex 5.3 untuk lane cepat.                |
| Backup GPT hemat token               | `gpt-5.4-token-saver`   | GPT-5.4 tetap untuk keputusan kritis, worker dipindah ke Codex 5.1 Mini. |
| Campuran seimbang kualitas/kecepatan | `codex-5.3-hybrid`      | Orkestrasi Codex dengan worker Gemini + Sonnet.                          |
| Stack Codex satu keluarga            | `codex-5.3-all`         | Semua agent/kategori tetap di keluarga Codex.                            |
| Codex utama + riset Gemini kuat      | `codex-5.3-gemini`      | Codex memimpin, Gemini menangani mayoritas worker/riset.                 |
| Hanya Codex + Sonnet                 | `codex-5.3-sonnet-4.6`  | Setup dua keluarga fokus jalur kualitas Codex + Sonnet.                  |
| Throughput cepat Gemini-only         | `gemini-3-all`          | Satu keluarga Gemini (3.1 Pro + 3 Flash), tanpa Claude.                  |
| Akurasi maksimum untuk role kritis   | `opus-4.6-lead`         | Opus memimpin role kritis, worker campuran menjaga throughput.           |
| Stack campuran Claude-led seimbang   | `sonnet-4.6-lead`       | Sonnet memimpin role inti, worker campuran tetap efisien.                |
| Stack Sonnet satu keluarga           | `sonnet-4.6-all`        | Semua agent/kategori tetap di keluarga Sonnet.                           |

### Decision Tree Pilih Profile

Pakai jalur cepat ini kalau masih bingung:

1. Butuh satu keluarga model untuk semua agent/kategori?
   - Ya -> `codex-5.3-all`, `gemini-3-all`, atau `sonnet-4.6-all`
   - Tidak -> lanjut
2. Butuh default harian kualitas tertinggi?
   - Ya -> `gpt-5.4-best-perform`
   - Tidak -> lanjut
3. Butuh GPT-5.4 sebagai backup untuk lane kualitas tinggi?
   - Ya -> pilih salah satu:
     - `gpt-5.4-best-perform` untuk kualitas maksimum
     - `gpt-5.4-token-saver` untuk worker yang lebih hemat token
   - Tidak -> lanjut
4. Butuh strategi GLM yang ringan?
   - Ya -> `glm-4.7-lite-token-saver`
   - Tidak -> lanjut
5. Ingin Codex jadi otak utama?
   - Ya -> pilih salah satu:
     - `codex-5.3-hybrid` (Codex + worker Gemini + Sonnet)
     - `codex-5.3-all` (satu keluarga Codex)
     - `codex-5.3-gemini` (Codex + worker Gemini)
     - `codex-5.3-sonnet-4.6` (Codex + Sonnet saja)
   - Tidak -> lanjut
6. Butuh akurasi tertinggi untuk role kritis (arsitek/debug/security)?
   - Ya -> `opus-4.6-lead`
   - Tidak -> lanjut
7. Butuh flow Claude-led yang seimbang dengan worker campuran?
   - Ya -> `sonnet-4.6-lead`
8. Kalau masih ragu, mulai dari `gpt-5.4-best-perform`, lalu pakai `codex-5.3-token-saver` saat mau jalur Codex-first yang lebih hemat.

### Memilih Mode Agent (Sisyphus, Hephaestus, Prometheus, Atlas)

Kalau di UI kamu muncul beberapa mode agent, pakai mapping cepat ini:

| Mode agent   | Use case terbaik                                              | Contoh prompt                                                        |
| ------------ | ------------------------------------------------------------- | -------------------------------------------------------------------- |
| `Sisyphus`   | Daily driver umum, implementasi end-to-end, eksekusi seimbang | "Implement fitur ini dan jalankan verifikasi lengkap."               |
| `Hephaestus` | Eksekusi engineering mendalam, debug sulit, refactor kompleks | "Lacak bug flaky ini dan kirim perbaikan root-cause."                |
| `Prometheus` | Planning dan arsitektur sebelum coding                        | "Buat rencana implementasi konkret beserta risiko dan milestone."    |
| `Atlas`      | Beban eksekusi besar, batch task multi-langkah                | "Eksekusi checklist ini lintas modul dan laporkan progres per fase." |

Kalau ada varian mode (misalnya label khusus planning/executor di dropdown), pilih berdasarkan niat kerja:

- varian planning-focused -> pakai sebelum coding
- varian executor-focused -> pakai saat plan sudah jelas dan ingin delivery cepat
- varian deep-analysis -> pakai untuk error yang belum jelas atau perubahan berisiko tinggi

Rekomendasi cepat untuk user baru:

1. Mulai dari `Sisyphus`
2. Pindah ke `Prometheus` kalau butuh plan yang lebih rapi
3. Pindah ke `Hephaestus` untuk debugging mendalam
4. Pindah ke `Atlas` untuk eksekusi batch skala besar

### Setelah ganti profile (penting)

Kalau `opencode web` masih berjalan lalu kamu ganti profile lewat `bun run setup:profile` atau `bun run setup:profile:update`:

1. Hentikan proses OpenCode di terminal tersebut (`Ctrl+C`)
2. Jalankan ulang OpenCode dengan port yang sama seperti sebelumnya

```bash
opencode web --port 8089
```

Kalau tidak sengaja ganti port, sering terlihat seolah-olah perubahan profile belum terpasang.

Kalau setelah `Ctrl+C` port yang sama masih error (terlihat seperti keblock di Windows), jalankan:

```powershell
taskkill /IM node.exe /F
```

Lalu jalankan lagi OpenCode di port yang sama:

```bash
opencode web --port 8089
```

---

## Update ke Versi Terbaru

Saat ada versi baru rilis, jalankan salah satu opsi berikut dari dalam folder repository.

**Opsi A — Update standar** (aman, cocok jika kamu punya perubahan lokal yang ingin dipertahankan):

```bash
git pull --ff-only origin main
bun run setup:profile:update
```

`git pull --ff-only` mengambil versi terbaru tanpa menulis ulang history lokal. Jika branch lokalmu sudah diverge dari remote (misalnya ada commit yang tidak sengaja kamu buat), perintah ini akan berhenti dan meminta kamu menyelesaikan konflik terlebih dahulu. File `oh-my-opencode.json` / `oh-my-openagent.json` yang dihasilkan berada di `~/.config/opencode/`, bukan di root repository.

**Opsi B — Hard reset update** (direkomendasikan untuk kebanyakan user — selalu identik dengan remote):

```bash
git fetch origin
git reset --hard origin/main
bun run setup:profile:update
```

`git fetch` mengunduh state terbaru dari remote tanpa menyentuh file lokalmu. `git reset --hard` kemudian memaksa salinan lokalmu menjadi **identik** dengan remote — semua perubahan lokal, edit tidak sengaja, atau modifikasi yang belum di-commit akan dihapus. Ini tidak pernah gagal karena divergence dan merupakan pilihan paling aman jika kamu tidak pernah sengaja mengubah file di repo ini.

> **⚠️ PENTING:** Setelah update selesai, kamu WAJIB me-restart sesi OpenCode. Buka terminal tempat `opencode web` sedang berjalan, tekan `Ctrl+C` untuk mematikan prosesnya, lalu jalankan lagi dengan port yang sama (contoh: `opencode web --port 8089`).

---

## Plugin Stack

Config ini sudah dilengkapi empat plugin yang dikonfigurasi di `opencode.json`:

| Plugin                           | Fungsi                                                           | Butuh API key? |
| -------------------------------- | ---------------------------------------------------------------- | :------------: |
| `oh-my-openagent`                | Routing multi-agent dan 14 agen spesialis                        |     Tidak      |
| `@tarquinen/opencode-dcp`        | Dynamic Context Pruning — otomatis kurangi penggunaan token      |     Tidak      |
| `cc-safety-net`                  | Safety hook — blokir perintah shell berbahaya sebelum dieksekusi |     Tidak      |
| `@ramtinj95/opencode-tokenscope` | Analitik Token & Biaya                                           |     Tidak      |

Keempat plugin aktif otomatis — namun hanya setelah OpenCode di-restart sepenuhnya. Jika kamu menambahkan plugin ke `opencode.json` saat OpenCode sedang berjalan, kamu harus **matikan prosesnya dan jalankan ulang** agar plugin baru diunduh dan dimuat. Reload config saja tidak cukup.

> **Instalasi plugin ditangani otomatis oleh setup.** Menjalankan `bun run setup:profile:update` akan menginstall semua plugin ke `~/.config/opencode/node_modules`. Tidak perlu jalankan `bun install` secara manual.

Tidak perlu konfigurasi tambahan selain restart tersebut.

### Dynamic Context Pruning (DCP)

DCP secara diam-diam menghapus konten yang sudah tidak relevan dari riwayat percakapan sebelum setiap request LLM — duplikasi baca file, tulisan yang sudah digantikan, dan error lama — tanpa menyentuh sesi di disk. Ini mengurangi penggunaan token pada sesi coding panjang tanpa biaya tambahan.

**Slash command yang berguna** (ketik di kotak chat OpenCode):

| Command         | Fungsi                                                             |
| --------------- | ------------------------------------------------------------------ |
| `/dcp`          | Tampilkan bantuan DCP dan daftar command yang tersedia             |
| `/dcp context`  | Tampilkan ukuran konteks saat ini dan apa yang sudah dipangkas DCP |
| `/dcp stats`    | Statistik pemangkasan lengkap untuk sesi ini                       |
| `/dcp sweep`    | Jalankan pass pemangkasan secara manual                            |
| `/dcp distill`  | Rangkum sebagian riwayat menjadi ringkasan                         |
| `/dcp compress` | Kompres riwayat percakapan untuk mengurangi jumlah token           |
| `/dcp prune`    | Hapus item tertentu dari konteks secara manual                     |
| `/dcp manual`   | Buka manual DCP / dokumentasi lengkap                              |

Opsional: buat `~/.config/opencode/dcp.jsonc` untuk pengaturan kustom (threshold kompresi, daftar tool yang dilindungi). Default sudah bekerja dengan baik tanpa konfigurasi.

Kalau muncul `DCP: Invalid config` dengan unknown key seperti `pruningStrategies.*`, berarti file kamu masih memakai key legacy. Backup dulu `~/.config/opencode/dcp.jsonc`, lalu reset jadi:

```jsonc
{
  "$schema": "https://raw.githubusercontent.com/Opencode-DCP/opencode-dynamic-context-pruning/master/dcp.schema.json",
}
```

### Safety Net (`cc-safety-net`)

Hook PreToolUse yang mencegat perintah Bash sebelum LLM menjalankannya. Memblokir operasi yang diketahui dapat menyebabkan kerusakan permanen:

- `git reset --hard`
- `rm -rf` di luar direktori kerja saat ini
- `git push --force` ke main/master
- Bypass shell wrapper (misal: `bash -c "rm ..."`)
- One-liner interpreter yang melewati inspeksi hook

Jika perintah yang diblokir memang disengaja, kamu akan diminta konfirmasi sebelum dieksekusi.

**Verifikasi sudah aktif** setelah install:

```bash
npx cc-safety-net doctor
```

### Plugin Opsional

Plugin berikut sudah ada di `opencode.json`-mu dan **tidak perlu setup apapun** — akan ter-install otomatis saat OpenCode pertama kali start setelah setup dijalankan.

#### `@ramtinj95/opencode-tokenscope` — Analitik Token & Biaya

Melacak penggunaan token per sesi dengan chart ASCII, rincian biaya per agent, dan harga untuk 41+ model. Berguna untuk memahami konsumsimu di sesi panjang. **Tidak perlu setup apapun** — aktif otomatis setelah restart pertama.

> **Catatan untuk pengguna Antigravity**: Estimasi biaya yang ditampilkan tokenscope mencerminkan harga bayar-per-token publik, bukan biaya aktual langgananmu.

---

## Troubleshooting

| Masalah                                                             | Solusi                                                                                                                                                                                                                                                                                                                                               |
| ------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `404 Not Found` saat cek repo                                       | Kamu belum punya akses repo — hubungi pemilik untuk mendapatkan undangan                                                                                                                                                                                                                                                                             |
| `gh: command not found`                                             | Install GitHub CLI dulu: [cli.github.com](https://cli.github.com)                                                                                                                                                                                                                                                                                    |
| `bun: command not found`                                            | Install dari [bun.sh](https://bun.sh), restart terminal                                                                                                                                                                                                                                                                                              |
| `ocs` atau `opencode: command not found`                            | Buka terminal baru dulu. Di macOS/Linux jalankan `ocs doctor`, lalu `ocs doctor --fix` jika remediasi ditawarkan. Gunakan `export PATH=... && hash -r` hanya sebagai fallback darurat sambil menyelidiki kenapa shell snippet persisten belum termuat. Di Windows buka PowerShell baru, jalankan `Get-Command ocs`, `Get-Command opencode`, lalu `ocs doctor` (atau `ocs doctor --fix`).      |
| `Authentication failed` saat cek repo                               | Jalankan `gh auth login -h github.com -w` dan pastikan pakai akun yang diundang                                                                                                                                                                                                                                                                      |
| `GraphQL: Could not resolve to a Repository`                        | Akun yang login salah atau undangan repo belum di-accept. Jalankan `gh auth login -h github.com -w`, lalu cek dengan `gh repo view andyvandaric/andyvand-opencode-config`                                                                                                                                                                            |
| LSP tidak berfungsi                                                 | Jalankan `bun run setup:profile:update`                                                                                                                                                                                                                                                                                                              |
| Perubahan profile terasa tidak masuk                                | Hentikan `opencode web` (`Ctrl+C`) lalu jalankan lagi dengan port yang sama seperti sebelumnya                                                                                                                                                                                                                                                       |
| Script gagal di Windows / `Unexpected token '??'`                   | Kamu masih jalan di Windows PowerShell 5.1. Jalankan installer pakai `pwsh` (PowerShell 7). Lihat panduan di bawah.                                                                                                                                                                                                                                  |
| `winget` tidak ditemukan                                            | Kamu pakai Windows yang di-strip (misal Ghost Spectre). Installer akan menangani otomatis — atau download manual dari [git-scm.com](https://git-scm.com/download/win) dan [cli.github.com/releases](https://github.com/cli/cli/releases/latest)                                                                                                      |
| `Error: Unable to connect. Is the computer able to access the url?` | OpenCode server tidak jalan, port berubah, atau proses node lama masih menahan port. Kembali ke terminal, jalankan `opencode web --port 8089` (pakai port yang sama seperti sebelumnya), lalu refresh browser. Jika port tetap keblock di Windows, jalankan `taskkill /IM node.exe /F` lalu coba lagi. Kalau perlu, ganti port (misal `--port 8090`) |
| `Skill "skill_mcp" not found`                                       | Tool `ccs` belum terinstall. Jalankan: `npm install -g @kaitranntt/ccs` (atau via pnpm/bun), lalu restart OpenCode                                                                                                                                                                                                                                   |
| Status layanan CocoIndex tidak jelas                                | Jalankan `ocs index status` untuk memastikan server MCP `ccc mcp` terdaftar dan sehat sebelum menyentuh data.                                                                                                                                                                                                                                        |
| Perlu memantau log CocoIndex                                        | Jalankan `ocs index logs --tail 200 --follow` agar kamu bisa streaming STDIO panjang `ccc mcp`. Biarkan shell terbuka selama log mengalir.                                                                                                                                                                                                           |
| CocoIndex masih bermasalah                                          | Jalankan `ocs index doctor` untuk menjalankan pemeriksaan kesehatan dan remedi runtime `ccc`.                                                                                                                                                                                                                                                        |
| Harus rebuild data CocoIndex                                        | Jalankan `ocs index rebuild --force`. Tambahkan `--hard-reset` hanya kalau kamu mau menghapus semua file `.mdb` dan mulai dari nol (pilihan terakhir).                                                                                                                                                                                               |

---

### Triase divergensi path/lingkungan Windows

Instalasi pada mesin yang variabel `USERPROFILE`/`HOME`-nya hilang, kosong, atau dikunci kebijakan sekarang memicu hybrid path guard yang mencoba fallback aman satu kali (folder spesial `UserProfile`) sebelum berhenti secara deterministik. Daripada crash dengan `Cannot bind argument to parameter 'Path' because it is an empty string`, installer keluar dengan marker terstruktur `[OCS_INSTALLER_PATH_RESOLUTION_FAILED]`, menulis payload diagnostik JSON, dan menampilkan rencana aksi yang sama setiap kali.

1. **Periksa variabel lingkungan** — jalankan `pwsh -NoProfile -Command "Write-Output USERPROFILE=$env:USERPROFILE; Write-Output HOME=$env:HOME"` atau `Get-ChildItem env:USERPROFILE`, `Get-ChildItem env:HOME`. Nilai kosong, hanya whitespace, atau tidak ada akan memicu guard, jadi pastikan keduanya menunjuk ke folder nyata.
2. **Validasi fallback** — guard akan fallback ke folder spesial `UserProfile` (dasar yang sama dipakai untuk `~/.config/opencode` dan `.opencode-suites`). Jalankan `pwsh -NoProfile -Command "$fb = [Environment]::GetFolderPath('UserProfile'); Write-Output \"Fallback=$fb\"; Test-Path $fb"` dan pastikan folder itu ada, bisa ditulis, dan tidak berada di `C:\Windows`, `System32`, atau `PolicyDefinitions/GroupPolicy`. Folder dengan wildcard `*`/`?` atau yang dikontrol kebijakan ditolak sebelum ada penulisan file apa pun.
3. **Gunakan path pengganti bila perlu** — pesan diagnostik meminta kamu menjalankan ulang dengan override `OCS_USER_HOME` jika path profil normal tidak tersedia. Arahkan override tersebut ke folder writable yang sesuai pola hybrid fallback (misal `C:\Users\SafeAccount`) lalu jalankan kembali installer.
4. **Ambil file diagnostik** — output error juga mencetak `diagnosticFilePath` di `%TEMP%/ocs-install-<runId>/diagnostics/path-resolution-<runId>.log`. Lampirkan file itu pada tiket support karena memuat payload JSON dengan `reasonCode`, `shortReason`, `primaryPath`, `fallbackPath`, `host`, `psVersion`, `runId`, dan `diagnosticFilePath`.

#### Kode alasan yang muncul

| Kode | Arti |
| ---- | ---- |
| `E_HOME_EMPTY` | Variabel lingkungan menghasilkan string kosong atau hilang padahal fallback ada. |
| `E_HOME_UNRESOLVED` | Baik variabel lingkungan maupun fallback tunggal tidak menghasilkan path yang valid. |
| `E_HOME_NOT_WRITABLE` | Path yang ditemukan berada di area sistem yang tidak bisa ditulisi oleh user biasa. |
| `E_FALLBACK_INVALID` | Path kandidat mengandung karakter wildcard/tidak aman atau gagal pemeriksaan keamanan. |
| `E_POLICY_BLOCKED` | Folder berada di bawah kebijakan Windows (`PolicyDefinitions`/`GroupPolicy`) dan dilarang secara eksplisit. |

Setiap kegagalan menulis `[OCS_INSTALLER_PATH_RESOLUTION_FAILED]` serta daftar aksi deterministik (verifikasi `USERPROFILE`/`HOME`, pastikan fallback bisa ditulis, jalankan ulang dengan `OCS_USER_HOME`, lampirkan file diagnostik). Ini memastikan tidak ada penulisan token, Bun shim, atau plugin yang menerima path kosong atau tidak aman.

Jika masih belum bisa menyelesaikan path profil setelah langkah-langkah tersebut, ambil nilai `diagnosticFilePath` yang muncul di baris error dan kirimkan ke support beserta kode alasan yang terlihat di layar; log itu adalah sumber kebenaran untuk kontrak diagnostik dan mempercepat triase.

### Windows: instal & verifikasi PowerShell 7 (penting)

Installer online memakai sintaks PowerShell 7. Kalau dijalankan di `powershell.exe` (Windows PowerShell 5.1), bisa muncul parser error seperti `Unexpected token '??'`.

Gunakan command ini untuk install di Windows:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex"
```

Verifikasi PowerShell 7 sudah terpasang:

```powershell
pwsh --version
pwsh -NoProfile -Command "$PSVersionTable.PSVersion"
```

Cara install PowerShell 7 di Windows (pilih salah satu):

- `winget install --id Microsoft.PowerShell --source winget`
- Microsoft Store: cari **PowerShell** (Publisher: Microsoft)
- MSI installer: https://github.com/PowerShell/PowerShell/releases/latest

Kalau terminal masih kebuka ke Windows PowerShell 5.1, pakai full path `pwsh`:

```powershell
& "$env:ProgramFiles\PowerShell\7\pwsh.exe" -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/andyvandaric/opencode-suites-installer/main/install.ps1 | iex"
```

---

> Untuk referensi konfigurasi lengkap, lihat bagian [Configuration](../README.md#-configuration) di README.
