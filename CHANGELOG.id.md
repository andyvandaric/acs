# Changelog

Semua perubahan penting yang berdampak langsung pada pengguna Agnostic Config Suites (ACS) didokumentasikan di sini.
Catatan rilis ini menyoroti manfaat nyata bagi pengguna, peningkatan performa, dan kenyamanan alur kerja pengembangan otonom.

## [v1.48.0] - 2026-11-27

### Ditambahkan
- **Pembaruan Mandiri Bertiket Terotorisasi**: `acs update` kini otomatis membuat tiket unduhan sekali pakai dengan progress bar terminal inline dan batas waktu stream 10 menit agar pembaruan tetap andal di koneksi lambat.
- **Versi HUD Dinamis & Sinkronisasi Aset Startup**: Statusline dan aset HUD tersinkronisasi otomatis saat startup dengan tampilan versi aktif yang akurat.

### Diperbaiki
- **Sesi Browser Headed Persisten di Windows**: Menjaga visibilitas GUI browser headed dan sesi profil pengguna melalui CDP tanpa gangguan sisa integrasi browser lama.
- **Buffer Stream SSE 16 MiB & Stabilitas Event Loop**: Meningkatkan buffer pemindaian SSE ke 16 MiB untuk mencegah terpotongnya respons streaming berukuran besar serta mengatasi crash pada event loop browser.
- **Kebersihan Profil Bawaan**: Sanitasi menyeluruh pada aset profil browser bawaan agar workspace pengguna bersih sejak awal.

## [v1.47.0] - 2026-11-26

### Ditambahkan
- **Otomasi Browser SeleniumBase Pure CDP**: Menggantikan mesin browser lama dengan otomasi headless berbasis SeleniumBase Pure CDP yang hening tanpa jendela pop-up yang mencuri fokus, lengkap dengan pembaruan dokumentasi browser.

### Diperbaiki
- **Imunitas Subproses Agen terhadap Deadlock Sweeper**: Memperkuat daemon deadlock sweeper dengan whitelist ketat untuk CLI agen (`agy`) dan shell interaktif agar proses terminal berdurasi panjang tidak tertutup sepihak.
- **Auto-Heal Path Spasi pada HUD Statusline**: Dukungan tanda kutip otomatis dan perbaikan mandiri untuk path workspace yang mengandung spasi pada HUD statusline.
- **Favicon Resmi ACS di Browser**: Menetapkan logo resmi ACS sebagai favicon standar pada sesi browser dan dashboard.
- **Pemulihan Mandiri Chunk Stream 9router**: Menambahkan penjagaan otomatis untuk anomali kurung kurawal ganda pada chunk respons streaming LLM agar parsing output agen tetap lancar.
- **Sinkronisasi Changelog Bilingual**: Penerapan catatan rilis bilingual terkurasi ke CDN.

### Diubah
- **Indikator Pembaruan Global Lebih Bersih**: Menghapus dock mengambang `GlobalUpdateIndicator` demi tampilan dashboard yang lebih ringkas.

## [v1.46.0] - 2026-11-24

### Ditambahkan
- **7 Autonomous Reflex & Watchdog Swarm Multi-Agen**: Penguatan orkestrasi swarm eksekutif dengan watchdog SLA 300 detik, probe stagnasi 3-checkpoint, dan pengawasan detak jantung proaktif di semua runtime.
- **Intelijen Kode Stateless REST LSP (<2ms)**: Navigasi simbol AST, lompat ke definisi, pencarian referensi, dan diagnostik compiler instan (<2ms) untuk Go, TypeScript, Python, dan Rust.
- **Paritas Ekosistem Antigravity CLI**: Deteksi kelas satu dan integrasi native untuk AGY CLI (`agy`), installer otomatis satu-perintah, diagnostik kesehatan doctor, dan verifikasi environment.
- **Eksekusi Hook Headless Zero-Flicker**: Wakeup konsol in-process yang sepenuhnya meniadakan kedipan jendela terminal/conhost Windows demi pengalaman koding yang hening dan fokus.
- **Streaming Pembaruan Biner Bertiket**: Update biner langsung via saluran tiket unduhan terotorisasi dengan verifikasi kriptografi integritas payload.
- **Auto-Registrasi Dinamis & Session Bus**: Broker pesan instan antar-agen (`acs bus`) dengan detak jantung latar belakang, resolusi CallName persona, dan IPC transparan.
- **Karantina Browser Efemeral**: Refleks penghematan memori otomatis yang mengarantina skema browser agen jika tidak aktif dalam 60 detik demi menjaga kuota context token.
- **Konfirmasi Hapus 2-Tahap & Perlindungan Trashbin**: Modal konfirmasi soft-delete protektif menggantikan konfirmasi browser native dengan masa simpan 30 hari.
- **Hub Respons Pengembang Jarak Jauh**: Respons langsung tim developer dan tracking tiket kini tampil langsung di dashboard feedback.
- **Statusline Berdaulat & Telemetri**: Baris status 1-2 baris tanpa border yang menampilkan direktori aktif proyek, statistik git realtime, dan kontrak persona aktif.

### Diperbaiki
- **Kedipan Jendela Terminal Windows (Zero-Flicker)**: Mengeliminasi kedipan jendela konsol Windows pada eksekusi hook background dan booting sesi agy.
- **Isolasi Token & Notifikasi Per Sesi**: Pemisahan ketat context window antar sesi agen, menghilangkan kebocoran token lintas sesi dan gangguan alert HUD.
- **Deteksi Git Sub-Milidetik & SWR**: Invalidasi cache repositori di background tanpa blocking dan batas waktu stdin 25ms mencegah kedipan statusline.
- **Inisialisasi Lingkungan LSP**: Penataan tool LSP via adapter lokal untuk intelijen kode berkecepatan tinggi tanpa restart proses berat.
- **Alias Fleksibel Kanban & Higienitas Skema**: Normalisasi alias parameter task kanban dan pencegahan mutasi status kartu liar.
- **Resolusi Identitas & Resolver Workspace**: Jalur cepat resolusi workspace dengan kejelasan atribusi pembuat dan identitas default yang jujur.

### Diubah
- **Optimasi Cold Boot Jaringan**: Pemeriksaan ketersediaan port dipercepat dan caching kandidat versi untuk startup instan.

## [v1.45.0] - 2026-11-19

### Ditambahkan
- **Strategi Lean Progressive Disclosure**: Modularisasi aturan tata kelola (batas <24KB) dan pemuatan alat on-demand, memangkas overhead token aktif hingga >75% (footprint aktif <5.000 token).
- **Koding Hening Tanpa Gangguan (Headless Execution)**: Isolasi penuh background process di Windows tanpa kedipan jendela command prompt dan tanpa merebut kursor/fokus editor.
- **Siklus Hidup Browser MCP Efemeral**: Otomasi browser on-demand dengan batas memori <512MB RAM dan karantina otomatis saat idle.
- **Gerbang Lisensi Kernel & Validasi Otomatis**: Validasi instan kode unduhan dan lisensi resmi pada Turn-0 tanpa prompt berulang.
- **Pengoptimal Anggaran Token**: Mesin audit CLI (`acs antigravity-budget`) untuk menginspeksi, memangkas, dan mengukur konsumsi token prompt di seluruh suite.
- **Gerbang Konektivitas Preflight GUI**: Verifikasi preflight terpadu dan rekonsiliasi commit multi-tenant dengan promosi kartu task otomatis.
- **Template Workspace Mandiri (Self-Healing)**: Materialisasi konfigurasi template otomatis dan fallback perbaikan mandiri untuk workspace Antigravity.

### Diperbaiki
- **Relokasi Bebas-Konflik Tailscale**: Relokasi otomatis layanan bentrok ke port 8443, mengamankan proxy 9router pada port 443.
- **Kontrol Proxy MITM Satu-Klik**: Penguncian mutual dan elevasi hak akses satu-klik untuk sertifikat Root CA dan inspeksi trafik.
- **Konkurensi Database & Pemulihan Lock Bebas Macet**: Penanganan konkurensi SQLite WAL dan pelepasan otomatis index lock basi, mencegah kegagalan sesi koding paralel.
- **Pencegahan Kebocoran Blueprint Lintas-Proyek**: Menegakkan batasan proyek yang ketat mencegah percampuran task antar workspace bersamaan.
- **Pemulihan Memori Mandiri & UI Katalog**: Mengatasi overflow katalog MCP, menstabilkan badge status suite, dan memperkuat akses database SQLite.

### Diubah
- **Penyederhanaan Dashboard MCP & MITM**: Transformasi manajemen server MCP menjadi penguji konektivitas instan dan perampingan konfigurasi proxy.

## [v1.44.0] - 2026-11-18

### Ditambahkan
- **Swarm Multi-Agen Spesialis (23 Persona)**: Kolaborasi tim agen lintas divisi (Eksekutif, Platform, Kualitas, Intel) dengan pembagian tugas otonom.
- **Paritas Papan Kanban & Blueprint IDE**: Sinkronisasi dua arah real-time antara file blueprint markdown dan kartu tugas visual di dasbor.
- **Memori Second-Brain Berkecepatan Tinggi**: Pencarian semantik dan kata kunci secepat kilat dengan SQLite WAL dan FTS5 tanpa kebocoran memori (recall <10ms).
- **Cockpit Antigravity MITM Satu-Klik**: Cockpit inspeksi TLS native dengan manajemen file hosts Windows otomatis tanpa friksi.
- **Tata Kelola Kunci Lintas-Sesi & Watchdog 300 Detik**: Penguncian sessionbus yang ketat, timer SLA deterministik, dan sidik jari error proaktif.
- **Rotator Log In-Place Windows**: Isolasi log multi-proses dengan rotasi otomatis tanpa benturan penguncian file di Windows.

### Diperbaiki
- **Perlindungan Progres & Selesai Updater Stack**: Mencegah indikator selesai prematur dan status penyelesaian palsu saat update stack.
- **Stabilitas Spawn Daemon Windows**: Pengamanan descriptor file log saat peluncuran daemon latar belakang untuk mencegah proses macet.
- **Resolusi Git Root Multi-Workspace**: Koreksi penemuan direktori git pada monorepo berlapis dan submodul.
- **Pengikatan Sesi ID**: Mencegah penyelesaian kartu tugas sebelum waktunya dengan memvalidasi kepemilikan sesi agen aktif.

### Diubah
- **Konsolidasi Modal Dashboard**: Menghapus kartu redundan dan menyederhanakan kontrol pengelola workspace Antigravity.

## [v1.43.0] - 2026-11-16

### Ditambahkan
- **Intelijen Stateless REST LSP (<2ms)**: Definisi simbol, referensi, dan diagnostik langsung tanpa pemborosan proses berat.
- **Sinkronisasi Blueprint ke Kanban Otonom**: Refleks realtime yang secara otomatis mengubah checklist task markdown IDE menjadi kartu papan Kanban.
- **Izin Otonom Bebas Gangguan Prompt**: Pemberian izin alat bawaan untuk kelancaran eksekusi loop agen tanpa interupsi prompt persetujuan berulang.
- **Registri 20+ Persona Sub-Agen**: Peran spesialis otonom komprehensif dengan alias alat dual-namespace dan tata kelola eksekusi.
- **Daemon Pemeliharaan 9Router & Pemangkasan DB**: CLI pengoptimal latar belakang (`acs optimize-db`) dengan rotasi backup otomatis dan pembersih konfigurasi.
- **Mesin Penemu Multi-Proyek Dinamis**: Penemuan workspace dinamis untuk sapuan daemon dan sinkronisasi boot background.

### Diperbaiki
- **Pengikatan Port Dashboard 20130**: Isolasi port lingkungan yang ketat dan flag startup eksplisit untuk dashboard produksi.
- **Protokol Hook Pre-Invocation**: Menyelaraskan payload hook native dengan spesifikasi protobuf dan mengonsolidasikan pencocok skill on-demand.
- **Kolasi Timer Resolusi-Rendah Windows**: Menjamin identitas pengguna unik pada jam presisi Windows dalam konkurensi tinggi.
- **Pengaman Auto-Claim Backlog**: Mencegah klaim tugas liar di backlog saat lonjakan aktivitas hook.

### Diubah
- **Optimasi Eksekusi Hook**: Mengganti skrip wrapper eksternal dengan pemanggilan HTTP fetch inline berkecepatan tinggi.
- **Selektor UI Antigravity Terpadu**: Mengonsolidasikan dropdown konfigurasi menjadi satu antarmuka yang bersih.

## [v1.42.0] - 2026-11-14

### Ditambahkan
- **Streaming Diagnostik SSE Progresif**: Aliran telemetri server-sent events realtime dengan badge latensi langsung dan isolasi tier.
- **Kartu Dasbor 4-in-1 Efisiensi Cache & Token**: Visualisasi penggunaan token dan efisiensi cache prompt terpadu tanpa redundansi.
- **Pengumuman Selamat Datang Berversi Dinamis**: Mesin pengumuman rilis dan notifikasi versi langsung di dalam dashboard.
- **Pencatatan Transactional Tombstone Combo**: Dual-cache invalidation dan persistensi seed-once dengan paritas seeder MITM Antigravity.
- **Grafik Penggunaan Token Resolusi Tinggi**: Tooltip timeline resolusi tinggi, label per jam sumbu-x terformat, dan metrik kuota akurat.

### Diperbaiki
- **Pencegahan Timeout Streaming Diagnostik**: Peningkatan batas waktu Fiber WriteTimeout ke 180 detik untuk transmisi data SSE tanpa putus.
- **Render Banner Progres Langsung**: Mencegah tampilan status error prematur dengan merender banner progres aktif.
- **Penyelarasan Routing Default Gateway**: Sanitasi pembuatan changelog fallback dan perutean gateway bawaan 9router.
- **Paralelisme Test Suite Windows**: Membatasi paralelisme pengujian Windows ke 4 dan menaikkan timeout pengujian untuk stabilitas test gate.

## [v1.41.0] - 2026-11-11

### Ditambahkan
- **Manajemen Combo Model 9Router**: Rute dan handler CRUD combo 9router dengan UI modal yang mendukung penyusunan ulang item secara visual.
- **Penyimpanan Combo Reaktif**: Sinkronisasi cache instan dan mutasi reaktif saat konfigurasi combo diperbarui.
- **Fallback Installer Langsung**: Dukungan bypass instalasi yang sudah ada dan fallback otomatis untuk terminal WezTerm.
- **Integrasi Preset Routing Model**: Penggabungan pengelola combo ke panel konfigurasi Hermes dan routing model Claude.

### Diperbaiki
- **Sinkronisasi Variabel Environment In-Process**: Memastikan pembaruan konfigurasi langsung aktif pada proses yang sedang berjalan.
- **Batas Waktu Model Uji Ketahanan**: Perpanjangan batas waktu model 9router dalam pengujian beban ekstensif.

## [v1.40.0] - 2026-11-10

### Ditambahkan
- **Pemuat Model Tangguh dengan Cache TTL**: Cache memori performa tinggi dengan dukungan force-refresh manual untuk combo 9router.
- **Pemulihan Otomatis Terminal Interaktif**: Manajemen izin otomatis pada tugas yang sedang berjalan dengan pemulihan terminal mulus.
- **Windowing Kolom Progresif Kanban**: Penomoran halaman dan pemuatan kolom bertahap untuk proyek dengan ratusan kartu tugas.
- **Sintesis Walkthrough Otomatis**: Pelacakan riwayat pengerjaan dan pembuatan dokumentasi walkthrough otomatis pada tugas blueprint.

### Diperbaiki
- **Kompatibilitas Skema Combo Sekuensial**: Peningkatan kompatibilitas skema dan perbaikan otomatis tipe combo 9router.
- **Resolusi Proses Terminal PTY**: Penguatan pengikatan sesi aktif dan resolusi proses terminal pada workspace latar belakang.
- **Ketahanan Probe Distribusi CDN**: Kalibrasi interval coba ulang pada pemeriksaan kesehatan endpoint CDN.

## [v1.39.0] - 2026-11-09

### Ditambahkan
- **Mesin Pengetahuan Second-Brain**: Pengambilan semantik dan kata kunci hibrida dengan dukungan database SQLite WAL.
- **Verifikasi Tahap Blueprint Otomatis**: Evaluasi konteks cerdas dan promosi status tahap tugas secara mandiri.
- **Pemantau Koordinasi Multi-Agen**: Pemantauan proses realtime dan pelacakan status kerja agen secara langsung.
- **Brankas Kredensial Terenkripsi**: Penyimpanan dan resolusi aman untuk token agen dan API key model upstream.

### Diperbaiki
- **Benturan Pemeriksaan Kesehatan Konkuren**: Penguatan proses pemulihan layanan terhadap sapuan diagnostik bersamaan.
- **Penemuan Blueprint Proyek Bersarang**: Deteksi cerdas file blueprint pada monorepo dan struktur direktori bertingkat.
- **Stabilitas Daemon Latar Belakang**: Penstabilan loop pemulihan daemon saat terjadi benturan restart konkuren.

## [v1.38.0] - 2026-11-07

### Ditambahkan
- **Koordinasi Daemon Otomatis & Pemulihan Mandiri**: Loop pengawas tangguh untuk layanan dan scheduler latar belakang.
- **Probe Kesehatan Layanan Real-Time**: Logika coba ulang adaptif yang langsung mendeteksi port tidak responsif.
- **Penemuan Cepat Virtual Environment Python**: Akselerasi deteksi paket dan versi pada lingkungan virtual Python.
- **Gerbang Validasi Fase Commit**: Pelacakan sinkronisasi fase kerja dengan verifikasi commit bertahap.

### Diperbaiki
- **Mutex Startup Proses**: Perlindungan titik temu proses latar belakang dari duplikasi peluncuran daemon.
- **Pengerasan Distribusi Rilis**: Perlindungan anti-kebocoran data internal pada pipeline rilis.
- **Benturan Restart Daemon**: Eliminasi kondisi macet saat restart dipicu secara simultan.

## [v1.37.0] - 2026-11-06

### Ditambahkan
- **Konfigurasi Proyek Bertab**: Pengaturan endpoint AI upstream, input API key dengan masking aman, dan uji koneksi langsung.
- **Perisai Panik & Ketahanan Alat MCP**: Lapisan pencegah crash otomatis saat loop eksekusi alat berjalan pada throughput tinggi.
- **Buffer Stdio 16MB yang Diperluas**: Buffer komunikasi non-fatal untuk menangani konteks kode besar dan respon simbol.
- **Sistem Unduhan Bertiket Terbatas Waktu**: Validasi kriptografis bertiket aman untuk file biner rilis resmi.

### Diperbaiki
- **Pengaman Penghentian Tugas AI Latar Belakang**: Melindungi proses AI background agar tidak terhenti tiba-tiba saat pembaruan berlangsung.
- **Toleransi Cold Boot Lintas-OS**: Kalibrasi waktu startup untuk cold boot mulus di Windows dan Linux.
- **Optimasi Biner Windows**: Eliminasi peringatan positif palsu dari heuristik antivirus pada file biner Windows.

## [v1.36.1] - 2026-11-06

### Ditambahkan
- **Rincian Penggunaan Token Real-Time**: Visualisasi per-model dan pelacakan biaya token pada dasbor Penggunaan.
- **Pelacak Kuota Antigravity Langsung**: Metrik alokasi yang tersisa dengan pengaman pembagian nol.
- **Pra-Penilaian Ide Otomatis**: Alur kerja penentuan cakupan awal untuk eksplorasi ide arsitektur cepat.

### Diperbaiki
- **Pencatatan File OS Langsung untuk 9Router**: Pemisahan logging proses untuk mencegah pembekuan saat proses restart.
- **Pemantau Kesehatan Latar Belakang**: Loop restart otomatis yang memulihkan proses background jika tidak merespons.

## [v1.36.0] - 2026-11-06

### Ditambahkan
- **Standarisasi Namespace CLI `acs`**: Penyatuan nama perintah kanonikal tunggal di semua CLI, environment, dan alur kerja.
- **Routing Model & Endpoint Kustom**: Pemilih model fleksibel dengan dukungan `base_url` kustom, masking `api_key`, dan uji latensi.
- **Tangga Pemulihan Zombie Daemon 5-Tahap**: Eskalasi bertingkat untuk pemulihan daemon zombie dan backoff adaptif.
- **Session Bus & Koordinasi Tim**: Pembaruan detak jantung sesi, antrean pesan tervalidasi penerima, dan banner kotak masuk belum dibaca.
- **Tempat Sampah Soft-Delete Kanban**: Masa retensi 30 hari, mesin reseed blueprint, dan pembaruan status fase otomatis.
- **Kantor Virtual WebGL 3D & Pencarian Kode Cepat**: Tampilan spasial studio dan pencarian kode trigram cepat (`/api/memory/code-search`).

### Diperbaiki
- **Siklus Hidup Bersih Restart Proses**: Menghilangkan pola pembunuhan pohon proses pada restart daemon dan reklamasi port di Windows dan Linux.
- **Deteksi Otomatis Jalur Browser Windows**: Koreksi penemuan lokasi file browser Chrome dan Edge pada sistem pengujian.
- **Pencegahan Kunci Snapshot SQLite**: Penegakan penguncian transaksi langsung pada koneksi tulis untuk mencegah snapshot lock.

## [v1.35.0] - 2026-10-15

### Ditambahkan
- **Proyeksi Papan Kanban Ringan**: Kueri papan super cepat (parameter `light`) dengan windowing kolom selesai dan penomoran halaman.
- **Anke Command Center**: Antarmuka pusat komando eksekutif dan bilah navigasi untuk orkestrasi swarm multi-agen.
- **Modal PTY WebSocket Kanonikal**: Modal terminal interaktif langsung terikat pada kartu tugas aktif.
- **Nama Terkualifikasi Penuh MCP (`acs:core`)**: Standardisasi nama alat dengan circuit breaker pengawas per-server.
- **Fallback Cache Degradasi yang Aman**: Pemuatan cache tangguh dengan penanganan kesalahan bertipe dan pembersihan file basi.

### Diperbaiki
- **Resolusi Blueprint Fail-Closed**: Validasi ketat pada sinkronisasi blueprint, pemindaian kode, dan pembuatan commit.
- **Batas Waktu Eksekusi Alat**: Batasan timeout 5 menit dan pembatalan konteks bersih untuk eksekusi alat stdio.
- **Perlindungan Status Kanban**: Mencegah penurunan kartu yang selesai ke backlog saat rekonsiliasi data.
- **Keamanan Identitas Sesi**: Verifikasi kepemilikan AgentID untuk mencegah pengambilalihan sesi agen.

## [v1.34.0] - 2026-10-15

### Ditambahkan
- **Orkestrasi Swarm & Registri Sesi Terpadu**: Distribusi tugas multi-agen dengan auto-registrasi dan pelacakan detak jantung.
- **Perlindungan Bot Cloudflare Fail-Closed**: Pengerasan header verifikasi dan sanitasi data pada formulir publik.
- **Audit Riwayat Status Kartu Kanban**: Pencatatan log transisi status mendetail pada setiap perpindahan kartu tugas.
- **Aliran Sesi Terminal PTY Interaktif**: Streaming terminal realtime dengan pemulihan status dan pengikatan sesi agen.

### Diperbaiki
- **Loop Coba Ulang File System Windows**: Pengerasan operasi penulisan file atomik dengan coba ulang otomatis saat konkurensi tinggi.
- **Kelancaran Navigasi Cold-Start**: Rutinitas pemanasan latar belakang untuk menghilangkan kelambatan navigasi pada booting awal.
- **Reklamasi Proses Terbengkalai**: Rutinitas pembersih otomatis yang melepaskan proses background yatim piatu secara bersih.

## [v1.33.0] - 2026-10-12

### Ditambahkan
- **Klasifikasi Gerbang Tugas Tiga Lapis**: Penjenjangan otomatis jenis tugas (Tier 1 Langsung, Tier 2 PRD, Tier 3 Operasional) berdasarkan analisis dampak.
- **Perekam Pengesahan & Loop Umpan Balik**: Pencatatan bukti audit verifikasi yang menghubungkan vonis pengujian dengan dokumen rencana.
- **Badge Notifikasi Sesi Belum Dibaca**: Indikator jumlah pesan belum dibaca realtime pada detak jantung sesi aktif.

### Diperbaiki
- **Normalisasi Status Pelacak**: Penguraian status kartu yang akurat meniadakan tampilan badge phantom.
- **Pengemasan Rilis Biner**: Optimasi kompresi dan packaging untuk mencegah alarm palsu dari software keamanan.
- **Anggaran Latensi Cold-Start**: Kalibrasi toleransi latensi untuk eksekusi Windows tanpa risiko timeout.

## [v1.32.0] - 2026-10-11

### Ditambahkan
- **Penyimpanan Tugas & Identitas Sesi Kanonikal**: Basis data terpusat dengan penentuan sesi berbasis variabel environment.
- **Siaran Presensi Real-Time Kanban**: Siaran status pengguna via WebSocket tanpa jeda dan klaim tugas otomatis pada gerbang disetujui.
- **Distribusi Multi-Produk CDN**: Pipeline rilis cepat dengan isolasi mirror dan pemeriksaan kesehatan terpisah per produk.
- **Gateway Bot Telegram**: Integrasi webhook aman dengan pembatasan laju pesan dan pemformatan markdown otomatis.
- **Pengatur Beban CPU & Pencegah Deadlock**: Pembatasan konkurensi berbasis jumlah core CPU untuk lingkungan bersumber daya hemat.

### Diperbaiki
- **Probe Fallback WebSocket**: Pemeriksaan konektivitas tangguh yang menjaga kelancaran saat soket menyambung ulang.
- **Keandalan Trigger Database**: Eksekusi trigger sadar-view dan kalibrasi penghapusan data kedaluwarsa.
- **Isolasi Direktori Kerja Terminal**: Resolusi direktori kerja yang memastikan sub-agen selalu mulai pada workspace yang tepat.

## [v1.31.0] - 2026-10-08

### Ditambahkan
- **Sinkronisasi Blueprint Real-Time**: Sinkronisasi langsung antara rencana kerja markdown di IDE dengan kartu tugas Kanban.
- **Isolasi Peran Agen Spesialis**: Batasan konteks dan alur eksekusi terisolasi untuk masing-masing persona agen.
- **Cache Berlapis Operasi Git**: Akselerasi pemeriksaan status repositori dan pelacakan file yang diubah.

### Diperbaiki
- **Pengaman Anggaran Token Otonom**: Pencegahan loop pemborosan token pada sesi koding agen jangka panjang.
- **Efisiensi Memori Dokumen Markdown**: Optimasi pemrosesan dokumen besar untuk mencegah lonjakan pemakaian RAM.

## [v1.30.0] - 2026-10-06

### Ditambahkan
- **GUI Visual Pengelola Stack**: Kontrol satu klik untuk memulai, menghentikan, dan merestart seluruh service latar belakang.
- **Pembaruan Biner Otomatis Sovereign CDN**: Distribusi pembaruan biner mandiri yang mulus melalui jaringan CDN resmi.
- **Penyaring Log Sistem Interaktif**: Penyorotan kesalahan realtime dan inspeksi log langsung di dasbor web.

### Diperbaiki
- **Alokasi Port Dinamis**: Mengeliminasi benturan port dengan server pengembangan lain yang sedang aktif di komputer.
- **Penanganan Sinyal Shutdown Lintas-OS**: Pemrosesan terminasi proses yang bersih di sistem operasi Windows dan Linux.

## [v1.29.0] - 2026-10-05

### Ditambahkan
- **Peluncur Alat MCP Lokal & Jarak Jauh**: Validasi skema otomatis dan integrasi alat pengembang MCP.
- **Autentikasi Member Berbasis Web**: Single sign-on dan pengecekan hak lisensi instan via peramban.
- **Panduan Memulai Interaktif**: Dokumentasi langkah-demi-langkah untuk orientasi awal developer.

### Diperbaiki
- **Diagnostik Jaringan Lebih Jelas**: Pesan informatif dan ramah pengguna saat verifikasi lisensi offline.
- **Penyelarasan Tampilan Layar Resolusi Tinggi**: Perbaikan tata letak UI pada monitor berdensitas tinggi (High-DPI).

## [v1.28.0] - 2026-10-04

### Ditambahkan
- **Arsitektur Modular ACS**: Backend Go berkinerja tinggi dengan antarmuka web SolidJS yang disematkan langsung.
- **Papan Kanban Developer Bawaan**: Pelacakan kemajuan pengerjaan fitur terintegrasi langsung di CLI.
- **Broker Pesan Antar-Alat**: Komunikasi IPC lokal untuk mengoordinasikan proses-proses agen latar belakang.

### Diperbaiki
- **Inisialisasi Database SQLite**: Penguatan migrasi skema WAL dan pembuatan tabel pada saat pertama kali dijalankan.
- **Ukuran Biner yang Ramping**: Pembersihan simbol debug untuk meminimalkan ukuran file unduhan.
