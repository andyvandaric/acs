# Panduan Instalasi ACS CLI

Mulai cepat — install, setup, dan jalankan ACS dalam hitungan menit.

> **Catatan:** ACS CLI didistribusikan melalui private GitHub repository.
> Kamu perlu akses yang sudah di-approve sebelum install.
> Hubungi [WhatsApp](https://wa.me/6281289731212?text=Mau%20order%20ACS%20nya%2C%20mohon%20infonya%20ya) untuk pembelian dan mendapatkan undangan.

---

## Prasyarat

| Komponen | Cara Install | Catatan |
|----------|-------------|---------|
| **GitHub CLI** | [cli.github.com](https://cli.github.com) atau `winget install GitHub.cli` | Wajib untuk autentikasi |
| **PowerShell 7+** (Windows) | `winget install Microsoft.PowerShell` | Installer otomatis install jika belum ada |
| **Git** | [git-scm.com](https://git-scm.com) | Biasanya sudah ada |

### Login GitHub CLI

```bash
gh auth login -h github.com -w
```

Pilih **HTTPS** saat diminta, lalu selesaikan OAuth di browser.

### Verifikasi Akses

```bash
gh api repos/andyvandaric/agnostic-config-suites --jq '.full_name'
```

Jika output `andyvandaric/agnostic-config-suites` — akses sudah aktif. Jika error 404, hubungi support.

---

## Install

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/andyvandaric/acs/main/install.ps1 | iex
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/install.sh | bash
```

### Apa yang terjadi saat install:

1. ✅ Deteksi platform (windows/mac/linux, amd64/arm64)
2. ✅ Autentikasi via GitHub CLI token
3. ✅ Download binary dari private repo (~33MB)
4. ✅ Verifikasi integritas (SHA-256)
5. ✅ Install ke `~/.acs/bin/acs-cli`
6. ✅ Tambahkan ke PATH
7. ✅ Register sebagai persistent service (auto-start saat login)

---

## Setup

Setelah install, jalankan setup untuk konfigurasi environment:

```bash
acs-cli setup
```

Setup bersifat **idempotent** — aman dijalankan berulang kali.

### Yang di-setup:

| Step | Fungsi |
|------|--------|
| prerequisites | Cek tools yang dibutuhkan (git, python, bun, uv) |
| version-check | Pastikan binary terbaru |
| 9router | Install LLM proxy untuk multi-account routing |
| claude-code | Deploy konfigurasi Claude Code |
| hermes-agent | Deploy konfigurasi agent profiles |
| git-credential | Setup HTTPS auth untuk private repos |
| gateway | Setup Telegram bot (opsional, butuh token) |
| shared-skills | Deploy 27 agent skills |
| mcp-servers | Konfigurasi MCP tools |
| automation | Deploy hooks dan scheduled tasks |

### Setup dengan Telegram Gateway (opsional)

```bash
acs-cli setup --telegram-token "123456789:AAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

---

## Verifikasi

```bash
# Cek versi
acs-cli version

# Cek kesehatan sistem
acs-cli doctor

# Lihat status stack
acs-cli service status
```

**Output yang diharapkan:**
```
[acs-cli] Stack status:
  ✅ 9router          running (PID 12345, port 20128)
  ✅ gateway          3/3 running [acs-default, acs-coder, acs-reviewer]
  ✅ dashboard        running (PID 67890, port 20130)
  ✅ scheduler        running (PID 11111) — background tasks active
```

---

## Dashboard

Buka dashboard web:

```bash
acs-cli dashboard
```

Atau langsung ke `http://localhost:20130` di browser.

---

## Update

ACS CLI cek update otomatis setiap 6 jam. Untuk update manual:

```bash
acs-cli update
```

Atau jalankan ulang installer — otomatis download versi terbaru.

---

## Uninstall

### Windows

```powershell
irm https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.ps1 | iex
```

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/andyvandaric/acs/main/uninstall.sh | bash
```

Atau via CLI:
```bash
acs-cli uninstall          # Hapus service + binary
acs-cli uninstall --purge  # Hapus semua termasuk data
```

---

## Troubleshooting

| Masalah | Solusi |
|---------|--------|
| `gh: command not found` | Install GitHub CLI: [cli.github.com](https://cli.github.com) |
| `404 Not Found` saat verifikasi akses | Akun belum di-invite ke repo. Hubungi support. |
| "Access denied" saat setup legacy-services | Normal di non-admin shell. Abaikan atau jalankan sebagai admin. |
| Binary terlalu kecil (< 1MB) | Git LFS pointer ter-download. Pastikan `gh auth status` benar. |
| Service tidak auto-start | Jalankan `acs-cli service install` lalu `acs-cli service start` |
| "file being used by another process" | Stop service dulu: `acs-cli service stop --force`, lalu install ulang |
| PowerShell error `Unexpected token` | Kamu di PS5. Installer otomatis re-launch ke PS7, tapi jika gagal: `winget install Microsoft.PowerShell` |

---

## Bantuan

```bash
acs-cli help              # Semua commands
acs-cli <command> --help  # Help per command
acs-cli doctor            # Diagnosa + auto-fix
```

---

> Dokumentasi lengkap tersedia di dashboard setelah instalasi.
> Untuk pertanyaan: [WhatsApp Support](https://wa.me/6281289731212)
