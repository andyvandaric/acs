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

Anda menggunakan agen AI coding untuk membangun software kelas dunia, bukan untuk membuang berjam-jam waktu Anda mengurai file konfigurasi atau melihat *context window* Anda lenyap sebelum baris kode pertama ditulis.

**Agnostic Config Suites (ACS)** adalah **Sistem Operasi Berdaulat Lokal (Local Sovereign OS)** berperforma tinggi. ACS mengubah agen AI yang rentan dan boros token menjadi mesin rekayasa perangkat lunak otonom yang tangguh, hemat biaya, dan deterministik.

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

ACS dilindungi oleh lisensi komersial terproteksi:

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
| `acs mcp [list\|add\|remove]` | Mengelola server dan tools Model Context Protocol (MCP) |
| `acs accounts` | Mengelola akun penyedia model AI dan alokasi kuota |
| `acs articles` | Mesin penelusuran artikel riset dan basis pengetahuan offline |
| `acs sessions` | Memeriksa dan mengelola riwayat sesi eksekusi agen AI |
| `acs logs` | Memantau log gabungan layanan secara realtime |

---

### ✨ Keunggulan Arsitektur ACS

1. **Integrasi Model Context Protocol (MCP) Bawaan**: Terhubung mulus ke sistem berkas, otomasi browser, code intelligence berbasis Language Server (LSP), dan riset web.
2. **Arsitektur Token Siaga Nol (Zero-Idle-Token)**: Mengurangi pemborosan token latar belakang hingga 89%, menyediakan ruang konteks maksimal untuk pembuatan kode.
3. **Smart Circuit Breaker Anti-Flapping**: Deteksi dini kegagalan jaringan dan masa tenggang menjamin stabilitas tanpa siklus restart berulang.
4. **Relay Cerdas Kuota Otonom (EDF)**: Algoritma cerdas memprioritaskan akun kuota AI yang mendekati batas reset untuk efisiensi maksimal.
5. **Deteksi Otomatis Proyek Lintas Workspace**: Secara otomatis mengenali seluruh workspace dan menyajikan status PRD blueprint pada kokpit Kanban.

---

<div align="center">
<b>Dibangun untuk para software engineer berkecepatan tinggi.</b><br>
Distribusi Resmi & Sovereign CDN: <a href="https://dl.uikode.com">https://dl.uikode.com</a>
</div>
