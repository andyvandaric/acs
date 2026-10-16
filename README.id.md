# ACS: Agnostic Config Suites
*(Sistem Operasi Berdaulat Lokal & Kokpit Kendali untuk Autonomous AI Coding Agents)*

<div align="center">
<img src="https://dl.uikode.com/logo.svg" width="160" alt="Logo ACS">

![ACS](https://img.shields.io/badge/ACS-Agnostic_Config_Suites-blue?style=for-the-badge)
![Versi](https://img.shields.io/badge/Versi-1.35.0-orange?style=for-the-badge)
![Lisensi](https://img.shields.io/badge/Lisensi-Proprietary-red.svg?style=for-the-badge)
![Status](https://img.shields.io/badge/Stack-Production_Ready-brightgreen?style=for-the-badge)
[![Website](https://img.shields.io/badge/Official_Website-uikode.com%2Facs-6366f1?style=for-the-badge&logo=googlechrome&logoColor=white)](https://uikode.com/acs)

**Berhenti membakar token. Berhenti mengalami terminal freeze. Ambil kembali kendali berdaulat.**<br>
*(Stop burning tokens. Stop freezing terminals. Take back sovereign control.)*

[English](README.md) | [Bahasa Indonesia](#bahasa-indonesia)

🌐 **Portal Resmi & Lisensi Komersial:** [uikode.com/acs](https://uikode.com/acs)
</div>

---

<a id="bahasa-indonesia"></a>
## 🇮🇩 Bahasa Indonesia

### 📖 Tentang ACS
**Revolusi AI Coding Membutuhkan Fondasi Kedaulatan (Sovereign Foundation)**

Anda menggunakan agen AI coding untuk membangun software kelas dunia, bukan untuk membuang berjam-jam waktu Anda mengurai file konfigurasi atau melihat *context window* Anda lenyap sebelum baris kode pertama ditulis.

**Agnostic Config Suites (ACS)** adalah **Sistem Operasi Berdaulat Lokal (Local Sovereign OS)** berperforma tinggi. ACS mengubah agen AI yang rentan dan boros token menjadi mesin rekayasa perangkat lunak otonom yang tangguh, hemat biaya, dan deterministik.

Pelajari selengkapnya di [Portal Resmi](https://uikode.com/acs) — [ACS Core](https://uikode.com/acs) menyatukan CLI, kokpit dashboard, dan multi-agent swarm dalam satu biner berdaulat.

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

---

### ⚡ Panduan Cepat & Aktivasi Lisensi

ACS dilindungi oleh lisensi komersial terproteksi. Beli dan kelola lisensi di [Portal Lisensi Komersial](https://uikode.com/acs):

1. **Aktivasi Lisensi**:
   ```bash
   # Aktivasi langsung di terminal
   acs activate <kode-lisensi-anda>

   # Atau masuk menggunakan akun GitHub resmi yang terdaftar
   acs login
   ```

2. **Inisialisasi Lingkungan & Diagnosis Sistem**:
   ```bash
   # Sinkronisasi tools, template & workspace
   acs setup

   # Pemeriksaan sistem dan perbaikan mandiri
   acs doctor --fix
   ```

3. **Nyalakan Layanan & Kokpit Web Lokal**:
   ```bash
   acs start
   ```
   *Dashboard kokpit web langsung terbuka di `http://127.0.0.1:20130`.*

---

### 🛡️ Privasi Enterprise & Kedaulatan Data Lokal

- **Proteksi Lisensi Komersial**: Memerlukan lisensi resmi untuk penggunaan. Dirancang dengan validasi aman untuk privasi dan stabilitas saat offline.
- **Kedaulatan Data Lokal**: Seluruh riwayat prompt, metrik proyek, dan konfigurasi tersimpan 100% di mesin lokal Anda. Bebas dari pengiriman data ke pihak ketiga.
- **Operasional Senyap di Latar Belakang**: Layanan sistem dan auto-heal berjalan senyap di background tanpa gangguan jendela terminal di layar kerja Anda.
- **Arsitektur Layanan Mandiri**: Layanan dashboard dan proxy berjalan mandiri untuk memastikan stabilitas dan ketersediaan tinggi selama pemeliharaan.

---

### 💻 Daftar Perintah CLI `acs` Lengkap

Seluruh operasional dipersatukan di bawah perintah modern **`acs`**:

#### Operasional Inti & Lisensi
| Perintah | Deskripsi |
|---|---|
| `acs activate <key>` | Mengaktifkan lisensi komersial resmi pada workstation |
| `acs login` | Otentikasi dan klaim lisensi via GitHub OAuth |
| `acs status` | Menampilkan status lisensi, port, dan layanan aktif |
| `acs start` | Menyalakan layanan latar belakang dan kokpit web lokal (`:20130`) |
| `acs stop` | Menghentikan layanan ACS secara aman |
| `acs restart` | Restart cepat layanan ACS tanpa jeda panjang |
| `acs doctor [--fix]` | Memeriksa dependensi sistem dan auto-perbaikan |
| `acs update` | Memeriksa dan memasang pembaruan versi dari Sovereign CDN |
| `acs lang [id\|en]` | Mengganti bahasa antarmuka CLI (Bahasa Indonesia / English) |
| `acs uninstall` | Menghapus instalasi ACS dan layanan sistem secara bersih |

#### Layanan Sistem & Komponen
| Perintah | Deskripsi |
|---|---|
| `acs service [start\|stop\|status]` | Mengelola service otomatis sistem operasi |
| `acs dashboard` | Mengelola server dashboard web UI (`:20130`) |
| `acs scheduler` | Mengontrol scheduler tugas latar belakang dan auto-heal |
| `acs gateway` | Mengelola gateway multi-akun penyedia AI |
| `acs router` | Mengontrol proxy load-balancer multi-provider |
| `acs setup` | Menginisialisasi ulang konfigurasi workspace dan aturan agen |

#### Ekosistem Agen & Tools
| Perintah | Deskripsi |
|---|---|
| `acs kanban` | Papan visual pelacak tugas lokal dan pemantau PRD Blueprint |
| `acs adopt` | Adopsi repositori tercepat dengan AI profiler, guardrails, dan GUI animasi |
| `acs mcp [list\|add\|remove\|serve]` | Mengelola server dan tools Model Context Protocol (MCP) |
| `acs accounts` | Mengelola akun penyedia model AI dan alokasi kuota |
| `acs articles` | Mesin penelusuran artikel riset dan basis pengetahuan offline |
| `acs sessions` | Memeriksa dan mengelola riwayat sesi eksekusi agen AI |
| `acs logs` | Memantau log gabungan layanan secara realtime |

---

### ✨ Keunggulan Arsitektur ACS

1. **Integrasi Model Context Protocol (MCP) Bawaan**: Terhubung mulus ke sistem berkas, otomasi browser, code intelligence berbasis Language Server (LSP), dan riset web melalui 45 Built-In Core Stdio MCP Tools + 80 CloakBrowser Stealth Sub-Tools di atas server harness stdio JSON-RPC 2.0.
2. **Arsitektur Token Siaga Nol (Zero-Idle-Token)**: Mengurangi pemborosan token latar belakang hingga 89%, menyediakan ruang konteks maksimal untuk pembuatan kode.
3. **Smart Circuit Breaker Anti-Flapping**: Deteksi dini kegagalan jaringan dan masa tenggang menjamin stabilitas tanpa siklus restart berulang.
4. **Relay Cerdas Kuota Otonom (EDF)**: Algoritma cerdas memprioritaskan akun kuota AI yang mendekati batas reset untuk efisiensi maksimal.
5. **Deteksi Otomatis Proyek Lintas Workspace**: Secara otomatis mengenali seluruh workspace dan menyajikan status PRD blueprint pada kokpit Kanban. Jalankan `acs adopt` untuk adopsi repositori tercepat dengan AI profiler dan guardrails.
6. **Kanban Interaktif & Tata Kelola Visual**: Resolver URL kartu langsung, mesin diagram Mermaid pan-zoom interaktif, inspeksi commit, badge verifikasi ganda, dan pelacakan eksekusi multi-wave.
7. **Anke Command Center & Sovereign Session Bus**: Gateway orkestrator terpusat dengan kontrak persona CEO Anke, sink dual-dispatcher, workspace modal PTY in-place, dan manajemen namespace `acs:core` terpadu. Didukung 28 Role Personas berbasis Jinja2 SSOT (CEO Anke, Architect, Executor, Verifier, Bug Hunter, dan lainnya) dengan tool masking ketat.
8. **Dispatch DAG Otonom & Atestasi Keamanan**: Pembuka blokir DAG berbasis watchdog, gerbang stamp verifier yang ketat, klaim kartu fail-closed, pelacakan provenance SLSA, dan pertahanan integritas berbasis Sigstore.
9. **Sovereign Second Brain**: Sub-10ms Contentless Trigram Code Search (<0,5% disk, tanpa biaya vector API) dipadukan dengan SQLite FTS5 Memory Engine untuk recall keputusan dan milestone secara instan.
10. **Windows Zero-Console Flash Invariant**: Seluruh subprocess berjalan sepenuhnya tersembunyi via `internal/executil` (`CREATE_NO_WINDOW | DETACHED_PROCESS`) plus Win32 API `SW_HIDE` — tanpa popup terminal.
11. **Dashboard Web SolidJS**: Kokpit lokal 22 rute dengan Kanban SSOT 4-Tab dan Virtual Office (Anke Chat IPC bi-directional full-duplex via SSE) di `http://127.0.0.1:20130`.

---

<div align="center">
<b>Dibangun untuk para software engineer berkecepatan tinggi.</b><br>
🌐 Portal Resmi & Lisensi Komersial: <a href="https://uikode.com/acs">https://uikode.com/acs</a><br>
Beli dan kelola lisensi Anda di [ACS Core](https://uikode.com/acs) melalui [Portal Resmi](https://uikode.com/acs).
</div>
