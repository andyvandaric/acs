# ACS: Agnostic Config Suites
*(Sistem Operasi Berdaulat Lokal & Kokpit Kendali untuk Autonomous AI Coding Agents)*

<div align="center">
<img src="https://dl.uikode.com/logo.svg" width="160" alt="Logo ACS">

![ACS](https://img.shields.io/badge/ACS-Agnostic_Config_Suites-blue?style=for-the-badge)
![Versi](https://img.shields.io/badge/Versi-1.12.0-orange?style=for-the-badge)
![Lisensi](https://img.shields.io/badge/Lisensi-Proprietary-red.svg?style=for-the-badge)
![Status](https://img.shields.io/badge/Stack-Production_Ready-brightgreen?style=for-the-badge)

**Berhenti membakar token. Berhenti mengalami terminal freeze. Ambil kembali kendali berdaulat.**<br>
*(Stop burning tokens. Stop freezing terminals. Take back sovereign control.)*

[English](README.md) | [Bahasa Indonesia](#bahasa-indonesia)
</div>

---

<a id="bahasa-indonesia"></a>
## 🇮🇩 Bahasa Indonesia

### 📖 Tentang ACS
**Revolusi AI Coding Membutuhkan Fondasi Kedaulatan (Sovereign Foundation)**

Anda menggunakan agen AI coding untuk membangun software kelas dunia, bukan untuk membuang berjam-jam waktu Anda mengurai file JSON yang berantakan atau melihat *context window* Anda lenyap habis sebelum baris kode pertama ditulis.

**Agnostic Config Suites (ACS)** adalah **Sistem Operasi Berdaulat Lokal (Local Sovereign OS)** berperforma tinggi yang dibangun dengan Go. ACS mengubah agen AI yang rapuh dan boros token menjadi mesin rekayasa perangkat lunak otonom yang tangguh, hemat biaya, dan deterministik.

---

### 📦 Instalasi Resmi

Pasang biner terpadu `acs` langsung melalui Sovereign CDN:

**Windows** (PowerShell Administrator):
```powershell
irm https://dl.uikode.com/install.ps1 | iex
```

**Linux / macOS** (Bash / Zsh):
```bash
curl -fsSL https://dl.uikode.com/install.sh | bash
```

*(Mirror failover tersedia otomatis melalui GitHub Releases dan infrastruktur UIKode Edge).*

---

### ⚡ Panduan Cepat & Aktivasi Lisensi

ACS dilindungi oleh lisensi komersial terproteksi. Setelah instalasi selesai, aktifkan workstation Anda dalam hitungan detik:

1. **Aktivasi Lisensi**:
   ```bash
   # Aktivasi instan langsung di terminal
   acs activate <kode-lisensi-anda>

   # Atau masuk menggunakan akun GitHub resmi yang telah terdaftar
   acs login
   ```

2. **Inisialisasi Lingkungan & Diagnosis Sistem**:
   ```bash
   # Sinkronisasi otomatis MCP tools, template ruleset & workspace
   acs setup

   # Lakukan pemeriksaan 16 titik prasyarat dan auto-perbaikan mandiri
   acs doctor --fix
   ```

3. **Nyalakan Layanan & Kokpit Web Lokal**:
   ```bash
   acs start
   ```
   *Dashboard kokpit web langsung terbuka di `http://127.0.0.1:20130`.*

---

### 🛡️ Proteksi Enterprise & Kedaulatan Data Lokal

- **Aktivasi Berpembatas & Validasi Lisensi Offline**: Verifikasi lisensi terenkripsi dengan cache HMAC aman di workstation lokal. Anda tetap dapat bekerja offline tanpa bergantung pada koneksi internet harian.
- **Isolasi Penuh Single-Tenant**: 100% riwayat telemetri, database SQLite WAL, log eksekusi prompt, dan konfigurasi tersimpan secara eksklusif di mesin lokal Anda (`~/.acs/`). Nol kebocoran data ke cloud pihak ketiga.
- **Zero Console Window (Eksekusi Senyap di Latar Belakang)**: Pemanfaatan flag Win32 `CREATE_NO_WINDOW` dan proses terpisah menjamin seluruh daemon latar belakang, auto-heal watchdog, dan skrip pembantu berjalan senyap tanpa kedipan jendela konsol terminal di layar Anda.
- **Isolasi Siklus Hidup Proses Mandiri**: Penghentian atau restart layanan dashboard ACS berjalan terpisah dan tidak mematikan proxy `9router` (`:20128`). Lalu lintas agen AI yang sedang aktif tetap aman tanpa gangguan.

---

### 💻 Daftar Perintah CLI `acs` Lengkap

Seluruh operasional kini dipersatukan di bawah perintah modern **`acs`**:

#### Operasional Inti & Lisensi
| Perintah | Deskripsi |
|---|---|
| `acs activate <key>` | Mengaktifkan lisensi komersial resmi pada workstation lokal |
| `acs login` | Otentikasi dan klaim lisensi melalui browser via GitHub OAuth |
| `acs status` | Menampilkan masa aktif lisensi, kesehatan port, dan status layanan |
| `acs start` | Menyalakan daemon latar belakang dan kokpit web lokal (`:20130`) |
| `acs stop` | Menghentikan layanan dashboard ACS secara aman (9router tetap aktif) |
| `acs restart` | Restart cepat layanan ACS tanpa memutus koneksi proxy agen |
| `acs doctor [--fix]` | Memeriksa 16 titik prasyarat dependensi dan auto-perbaikan otomatis |
| `acs update` | Memeriksa dan memasang pembaruan versi terbaru dari Sovereign CDN |
| `acs lang [id\|en]` | Mengganti bahasa antarmuka CLI (Bahasa Indonesia / English) |
| `acs uninstall` | Menghapus instalasi ACS, layanan sistem, dan link biner secara bersih |

#### Layanan Sistem & Komponen
| Perintah | Deskripsi |
|---|---|
| `acs service [start\|stop\|status]` | Mengelola service otomatis sistem operasi (systemd / Task Scheduler) |
| `acs dashboard` | Mengelola server dashboard dan membuka web UI (`:20130`) |
| `acs scheduler` | Mengontrol scheduler tugas latar belakang dan auto-heal watchdog |
| `acs gateway` | Mengelola gateway multi-akun AI (Kiro, Antigravity, dll.) |
| `acs router` | Mengontrol proxy load-balancer multi-provider 9router (`:20128`) |
| `acs setup` | Menginisialisasi ulang konfigurasi workspace, tools, dan agen rules |

#### Ekosistem Agen & MCP
| Perintah | Deskripsi |
|---|---|
| `acs kanban` | Papan visual pelacak tugas lokal dan pemantau PRD Blueprint |
| `acs mcp [list\|add\|remove]` | Mengelola server dan tools Model Context Protocol (MCP) |
| `acs accounts` | Mengelola akun penyedia model AI (KeyPool) dan alokasi kuota |
| `acs articles` | Mesin penelusuran artikel riset dan basis pengetahuan offline |
| `acs sessions` | Memeriksa dan mengelola riwayat sesi eksekusi agen AI |
| `acs logs [service\|daemon\|9router]` | Memantau log gabungan layanan secara realtime tanpa terpotong |

---

### ✨ Keunggulan Arsitektur ACS

1. **Integrasi Model Context Protocol (MCP) Bawaan**: Terhubung mulus ke sistem berkas, otomasi browser (CloakBrowser), code intelligence berbasis AST Language Server (LSP), dan penelusuran riset mendalam.
2. **Arsitektur Token Siaga Nol (Zero-Idle-Token)**: Mengurangi pemborosan token latar belakang hingga 89%, menyediakan ruang *reasoning context* maksimal untuk penulisan kode.
3. **Smart Circuit Breaker Anti-Flapping**: Deteksi dini kegagalan jaringan dan masa tenggang *cold-boot* menjamin stabilitas tanpa siklus restart berulang.
4. **Relay Cerdas Kuota Otonom (EDF)**: Algoritma Earliest Deadline First memprioritaskan akun kuota AI yang mendekati batas reset untuk efisiensi maksimal.
5. **Deteksi Otomatis Proyek Lintas Workspace**: Secara otomatis mengenali seluruh workspace Claude Code CLI dan menyajikan status PRD blueprint pada kokpit Kanban.

---

<div align="center">
<b>Dibangun dengan bangga untuk para software engineer berkecepatan tinggi.</b><br>
Distribusi Resmi & Sovereign CDN: <a href="https://dl.uikode.com">https://dl.uikode.com</a>
</div>
