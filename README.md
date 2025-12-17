# Jawara Apps - Platform Manajemen Komunitas

Aplikasi mobile Flutter yang komprehensif untuk mengelola komunitas perumahan (RT/RW - Rukun Tetangga/Rukun Warga) di Indonesia.

**Daftar Isi**
- [Ringkasan Proyek](#ringkasan-proyek)
- [Arsitektur](#arsitektur)
- [Fitur Utama](#fitur-utama)
- [Peran Pengguna](#peran-pengguna)
- [Model Data](#model-data)
- [Halaman dan Layar](#halaman-dan-layar)
- [Layanan dan API](#layanan-dan-api)
- [Modul Inti](#modul-inti)
- [Stack Teknologi](#stack-teknologi)

---

## Ringkasan Proyek

**Nama Proyek:** Jawara Apps (Proyek PBL)  
**Tipe:** Aplikasi Mobile Flutter  
**Tujuan:** Platform terpusat untuk administrasi komunitas, manajemen penduduk, transaksi marketplace, dan pengumpulan pendapatan  
**Pengguna Target:** Pemimpin komunitas (Ketua RT/RW), administrator, bendahara, dan penduduk  
**Arsitektur:** Client-server dengan backend API RESTful  

---

## Arsitektur

### Arsitektur Frontend
- **Framework Navigasi:** GoRouter (v17.0.0) untuk deep linking dan manajemen status
- **Framework UI:** Flutter Material Design dengan tema berbasis ungu khusus
- **Manajemen Status:** Arsitektur berbasis layanan dengan pola Provider
- **Penyimpanan Lokal:** SharedPreferences untuk persistensi token dan data pengguna

### Arsitektur Backend
- **Server API:** API RESTful yang dihost di `http://virtualtech.icu:3030`
- **Autentikasi:** Autentikasi berbasis token JWT Bearer
- **Database:** Database API jarak jauh untuk semua operasi data

### Alur Data
1. Pengguna masuk melalui AuthService
2. Sistem menyimpan token JWT dan data pengguna secara lokal
3. Semua panggilan API berikutnya menyertakan token Bearer di header
4. Layanan menangani logika bisnis dan transformasi data
5. Halaman/Layar menampilkan data dan menangani interaksi pengguna

---

## Fitur Utama

| Fitur | Kategori | Deskripsi |
|-------|----------|-----------|
| **Autentikasi Pengguna** | Inti | Login dan pendaftaran email/password dengan akses berbasis peran |
| **Manajemen Pengguna** | Admin | Buat, perbarui, hapus pengguna sistem dengan penugasan peran |
| **Manajemen Penduduk (Warga)** | Inti | Kelola informasi penduduk dengan pelacakan NIK dan asosiasi keluarga |
| **Manajemen Keluarga (Keluarga)** | Inti | Organisir penduduk ke dalam keluarga dengan penunjukan kepala |
| **Manajemen Properti (Rumah)** | Inti | Lacak properti perumahan, kepemilikan, dan hunian |
| **Verifikasi Penduduk** | Admin | Tinjau dan setujui/tolak permintaan pendaftaran mandiri |
| **Marketplace Komunitas** | Fitur | Izinkan penduduk membeli/menjual barang dalam komunitas |
| **Sistem Transaksi** | Fitur | Lacak semua pembelian marketplace dan transaksi |
| **Manajemen Pendapatan (Pemasukan)** | Admin | Kelola kategori biaya, buat faktur, lacak pengumpulan |
| **Pencatatan Aktivitas** | Admin | Catat semua tindakan sistem dan aktivitas administratif |
| **Dashboard & Statistik** | Fitur | Tampilkan statistik komunitas dan informasi spesifik pengguna |
| **Kontrol Akses Berbasis Peran** | Keamanan | Antarmuka dan izin berbeda berdasarkan peran pengguna |

---

## Peran Pengguna

### 1. **Admin Sistem** (System Administrator)
- Tingkat hak istimewa tertinggi
- Kelola semua pengguna dan peran sistem
- Akses semua modul dan laporan
- Awasi semua operasi komunitas

### 2. **Ketua RT** (Pemimpin RT)
- Kelola penduduk dalam RT tertentu
- Verifikasi pendaftaran penduduk baru
- Kelola marketplace komunitas
- Awasi pengumpulan pendapatan
- Buat laporan komunitas

### 3. **Ketua RW** (Pemimpin RW)
- Kelola beberapa RT
- Pengawasan operasi RT
- Pelaporan tingkat sistem
- Manajemen acara komunitas

### 4. **Bendahara** (Treasurer)
- Kelola operasi keuangan
- Buat dan kelola faktur
- Lacak pendapatan dan pengumpulan
- Buat laporan keuangan

### 5. **Sekretaris** (Secretary)
- Manajemen dokumen
- Penyimpanan catatan
- Dukungan administratif
- Pembuatan laporan

### 6. **Warga** (Penduduk Biasa)
- Lihat informasi pribadi
- Jelajahi marketplace komunitas
- Buat pembelian
- Lihat riwayat transaksi
- Terima notifikasi

---

## Halaman dan Layar

### Halaman Autentikasi

#### LoginPage
- Kolom input email dan password
- Validasi dan penanganan kesalahan
- Fungsionalitas "Ingat saya"
- Tautan ke halaman pendaftaran
- Rute ke dashboard setelah login berhasil

#### RegisterPage
- Formulir pendaftaran pengguna (nama, email, password, telepon)
- Validasi email
- Konfirmasi password
- Penerimaan syarat
- Rute ke halaman login setelah pendaftaran berhasil

### Halaman Dashboard

#### HomeDashboardPage (Titik Masuk Utama)
**Untuk Admin/Pemimpin:**
- Pesan selamat datang dengan nama dan peran pengguna
- Widget statistik menampilkan:
  - Total penduduk (jumlah Warga)
  - Total keluarga (jumlah Keluarga)
  - Total properti (jumlah Rumah)
  - Aktivitas komunitas
- Tampilan log aktivitas terbaru
- Tombol tindakan cepat

**Untuk Penduduk Biasa (Warga):**
- Pesan selamat datang pribadi
- Pratinjau marketplace komunitas
- Ringkasan informasi pribadi
- Riwayat transaksi
- Acara komunitas mendatang

### Halaman Manajemen Pengguna

#### UserManagementPage
- Daftar semua pengguna sistem dengan kolom: Nama, Email, Telepon, Peran, Tindakan
- Fungsi pencarian dan filter
- Tombol tambah pengguna
- Tombol aksi edit/hapus

#### AddUserPage
- Formulir pendaftaran pengguna untuk pengguna sistem baru
- Bidang: Nama, Email, Password, Telepon, Peran
- Validasi formulir
- Tombol kirim

#### EditUserPage
- Formulir informasi pengguna yang sudah diisi sebelumnya
- Bidang yang dapat diedit
- Tombol perbarui
- Opsi hapus

#### UserDetailPage
- Tampilan hanya-baca informasi pengguna
- Tampilan informasi peran
- Tanggal pembuatan akun
- Tombol aksi (Edit, Hapus)

### Halaman Manajemen Penduduk

#### WargaPage (Daftar Penduduk)
- Tabel/Daftar semua penduduk
- Kolom: Nama, NIK, Gender, Keluarga, Status
- Cari berdasarkan nama atau NIK
- Tombol tambah penduduk
- Aksi lihat/edit/hapus

#### WargaFormPage (Tambah/Edit Penduduk)
- Formulir informasi penduduk
- Bidang: Nama, NIK, Gender, Asosiasi Keluarga, Status Domisili, Status Kehidupan
- Validasi formulir
- Tombol kirim (Buat atau Perbarui)

#### WargaDetailPage (Detail Penduduk)
- Tampilan informasi lengkap penduduk
- Detail asosiasi keluarga
- Informasi properti
- Informasi status
- Tombol edit/hapus

#### WargaSelfRegisterPage (Pendaftaran Mandiri)
- Formulir untuk penduduk baru mendaftarkan diri
- Pengumpulan informasi dasar
- Dikirimkan untuk verifikasi
- Pesan konfirmasi setelah pengajuan

### Halaman Manajemen Properti

#### RumahPage (Daftar Properti)
- Daftar semua properti perumahan
- Kolom: Alamat, Status, Keluarga, Penghuni
- Cari berdasarkan alamat
- Tombol tambah properti
- Aksi lihat/edit/hapus

#### RumahFormPage (Tambah/Edit Properti)
- Formulir informasi properti
- Bidang: Alamat, Status Kepemilikan, Keluarga, Jumlah Penghuni
- Validasi formulir
- Tombol kirim

#### RumahDetailPage (Detail Properti)
- Tampilan informasi properti
- Informasi keluarga yang terkait
- Informasi penduduk
- Detail kepemilikan
- Tombol edit/hapus

### Halaman Manajemen Keluarga

#### KeluargaPage (Daftar Keluarga)
- Daftar semua keluarga
- Kolom: Nama Keluarga, Kepala, Properti, Anggota
- Tombol tambah keluarga
- Aksi lihat/edit/hapus

#### KeluargaFormPage (Tambah/Edit Keluarga)
- Formulir informasi keluarga
- Bidang: Nama Keluarga, Pemilihan Kepala Keluarga, Pemilihan Properti, Jumlah Anggota
- Validasi formulir
- Tombol kirim

### Halaman Marketplace

#### MarketplaceWargaPage (Marketplace Penduduk)
- Jelajahi item komunitas yang tersedia untuk dijual
- Kartu item dengan:
  - Gambar produk
  - Nama dan deskripsi
  - Harga
  - Informasi penjual
- Fungsi pencarian
- Filter berdasarkan kategori
- Tombol beli
- Tautan riwayat transaksi

#### MarketplaceAdminPage (Manajemen Marketplace Admin)
- Daftar semua item marketplace
- Kolom: Nama Item, Harga, Penjual, Status, Tindakan
- Tombol tambah item
- Aksi edit/hapus/nonaktifkan
- Statistik item

#### MarketplaceFormPage (Tambah/Edit Item)
- Formulir informasi item
- Bidang: Nama, Deskripsi, Harga, Kategori, Gambar
- Fungsionalitas unggah gambar
- Manajemen kuantitas
- Tombol kirim

### Halaman Transaksi

#### HistoriTransaksiPage (Riwayat Transaksi)
- Daftar transaksi pengguna
- Kolom: Item, Tanggal, Kuantitas, Harga, Status
- Filter berdasarkan rentang tanggal
- Filter berdasarkan status
- Tampilan detail transaksi
- Tampilan tanda terima/faktur

### Halaman Manajemen Pendapatan

#### MenuPemasukan (Menu Pendapatan)
- Hub navigasi untuk fitur pendapatan
- Tautan cepat ke:
  - Kategori biaya
  - Manajemen faktur
  - Catatan pendapatan
  - Laporan pengumpulan

#### KategoriIuran (Kategori Biaya)
- Daftar tipe/kategori biaya
- Kolom: Nama Kategori, Deskripsi, Jumlah
- Tombol tambah kategori
- Aksi edit/hapus

#### DetailKategoriIuran (Detail Kategori)
- Informasi kategori biaya
- Faktur terkait
- Statistik

#### TagihIuranPage (Manajemen Penagihan)
- Buat faktur untuk penduduk
- Pilih penduduk dan tipe biaya
- Atur periode penagihan
- Pratinjau sebelum membuat
- Buat faktur

#### DaftarTagihan (Daftar Faktur)
- Daftar semua faktur
- Kolom: Nomor Faktur, Penduduk, Kategori, Jumlah, Tanggal, Status
- Filter berdasarkan status (Dibayar/Belum Dibayar)
- Lihat/Cetak faktur
- Tandai sebagai dibayar

#### DetailTagihan (Detail Faktur)
- Tampilan informasi faktur
- Rincian biaya
- Status pembayaran
- Tanggal jatuh tempo
- Opsi metode pembayaran

#### DaftarPemasukan (Daftar Pendapatan)
- Daftar semua pendapatan yang dicatat
- Kolom: Tanggal, Jumlah, Sumber, Kategori, Deskripsi
- Filter berdasarkan tanggal dan kategori
- Statistik pendapatan

#### DetailPemasukan (Detail Pendapatan)
- Informasi transaksi pendapatan
- Faktur terkait
- Metode pembayaran
- Informasi tanda terima

### Halaman Fitur Admin

#### VerificationWargaPage (Verifikasi Penduduk)
- Daftar permintaan pendaftaran mandiri yang tertunda
- Kolom: Nama, NIK, Email, Tanggal Pengajuan, Tindakan
- Tombol setujui
- Tombol tolak (dengan alasan)
- Lihat detail lengkap

#### KegiatanPage (Manajemen Aktivitas/Acara)
- Daftar aktivitas dan acara komunitas
- Buat aktivitas baru
- Edit/Hapus aktivitas
- Detail aktivitas (nama, tanggal, deskripsi, peserta)

#### DataWargaRumahPage (Hub Data)
- Manajemen pusat data penduduk dan properti
- Tautan cepat ke manajemen Warga, Rumah, dan Keluarga
- Statistik gambaran umum
- Perubahan terbaru

---

## Layanan dan API

### Layanan Autentikasi (AuthService)

**Tujuan:** Menangani autentikasi pengguna dan manajemen profil

**Metode Kunci:**
- `login(email, password)` - Autentikasi pengguna dan kembalikan token
- `register(name, email, password, phone)` - Buat akun pengguna baru
- `getProfile(token)` - Ambil informasi profil pengguna saat ini

**Endpoint API:**
- POST `/auth/login` - Autentikasi pengguna
- POST `/auth/register` - Pendaftaran pengguna baru
- GET `/auth/profile` - Ambil profil pengguna

**Data Tersimpan:**
- Token Bearer di SharedPreferences
- Informasi pengguna (nama, email, telepon, peran) di-cache secara lokal

---

### Layanan Warga (WargaService)

**Tujuan:** Kelola informasi dan operasi penduduk

**Metode Kunci:**
- `getAllWargaFromApi(token)` - Ambil semua penduduk
- `getMyWargaProfile(token)` - Dapatkan profil warga pengguna saat ini
- `getWargaByNikFromApi(token, nik)` - Cari penduduk berdasarkan ID Nasional
- `selfRegister(data)` - Pendaftaran mandiri untuk penduduk baru
- `updateWargaApi(id, data)` - Perbarui informasi penduduk
- `deleteWargaApi(id)` - Hapus catatan penduduk

**Endpoint API:**
- GET `/warga` - Daftar semua penduduk
- GET `/warga/{id}` - Dapatkan detail penduduk
- POST `/warga` - Buat penduduk baru
- PUT `/warga/{id}` - Perbarui penduduk
- DELETE `/warga/{id}` - Hapus penduduk
- POST `/warga/self-register` - Permintaan pendaftaran mandiri

**Layanan Terkait:** WargaApiService (panggilan API tingkat rendah)

---

### Layanan Keluarga (KeluargaService)

**Tujuan:** Kelola informasi keluarga/rumah tangga

**Metode Kunci:**
- `getAllKeluarga(token)` - Daftar semua keluarga
- `getKeluargaById(token, id)` - Dapatkan detail keluarga
- `createKeluarga(token, data)` - Buat keluarga baru
- `updateKeluarga(token, id, data)` - Perbarui informasi keluarga
- `deleteKeluarga(token, id)` - Hapus catatan keluarga

**Endpoint API:**
- GET `/keluarga` - Daftar semua keluarga
- GET `/keluarga/{id}` - Dapatkan detail keluarga
- POST `/keluarga` - Buat keluarga
- PUT `/keluarga/{id}` - Perbarui keluarga
- DELETE `/keluarga/{id}` - Hapus keluarga

**Layanan Terkait:** KeluargaApiService (panggilan API tingkat rendah)

---

### Layanan Rumah (RumahService)

**Tujuan:** Kelola informasi properti

**Metode Kunci:**
- `getAllRumah(token)` - Daftar semua properti
- `getRumahById(token, id)` - Dapatkan detail properti
- `searchRumah(query)` - Cari properti berdasarkan alamat
- `getRumahByKeluargaId(token, keluargaId)` - Dapatkan properti untuk keluarga
- `addRumah(token, data)` - Buat properti baru
- `updateRumah(token, id, data)` - Perbarui properti
- `deleteRumah(token, id)` - Hapus properti

**Endpoint API:**
- GET `/rumah` - Daftar semua properti
- GET `/rumah/{id}` - Dapatkan detail properti
- POST `/rumah` - Buat properti
- PUT `/rumah/{id}` - Perbarui properti
- DELETE `/rumah/{id}` - Hapus properti

**Layanan Terkait:** RumahApiService (panggilan API tingkat rendah)

---

### Layanan Marketplace (MarketplaceService)

**Tujuan:** Kelola daftar marketplace komunitas dan penjualan

**Metode Kunci:**
- `getAllItems(token)` - Daftar semua item marketplace
- `getItemById(token, id)` - Dapatkan detail item
- `createItem(token, data, imageFile)` - Buat daftar baru dengan gambar
- `updateItem(token, id, data)` - Perbarui daftar
- `deleteItem(token, id)` - Hapus daftar
- `searchItems(query)` - Cari item berdasarkan nama atau deskripsi

**Endpoint API:**
- GET `/marketplace` - Daftar semua item
- GET `/marketplace/{id}` - Dapatkan detail item
- POST `/marketplace` - Buat item (form multipart dengan gambar)
- PUT `/marketplace/{id}` - Perbarui item
- DELETE `/marketplace/{id}` - Hapus item

**Penanganan Gambar:** 
- Diunggah melalui data form multipart
- Disimpan di server dengan path: `/uploads`
- Diambil melalui: `{baseURL}/uploads/{filename}`

**Layanan Terkait:** MarketplaceApiService (panggilan API tingkat rendah)

---

### Layanan Transaksi (TransaksiService)

**Tujuan:** Menangani pembelian marketplace dan riwayat transaksi

**Metode Kunci:**
- `purchaseItem(token, marketplaceId, quantity)` - Beli item marketplace
- `getMyTransactions(token)` - Dapatkan riwayat transaksi pengguna
- `getAllTransactions(token)` - Dapatkan semua transaksi (admin)
- `getTransactionById(token, id)` - Dapatkan detail transaksi
- `createTransaction(token, data)` - Buat catatan transaksi baru

**Endpoint API:**
- POST `/transaction/purchase` - Buat transaksi pembelian
- GET `/transaction/my-history` - Transaksi pengguna
- GET `/transaction` - Semua transaksi (admin)
- GET `/transaction/{id}` - Detail transaksi

**Data Transaksi:**
- ID item marketplace, kuantitas, harga, tanggal, pembeli, status

**Layanan Terkait:** TransaksiApiService (panggilan API tingkat rendah)

---

### Layanan Verifikasi (VerificationService)

**Tujuan:** Kelola proses verifikasi pendaftaran mandiri penduduk

**Metode Kunci:**
- `getAllVerifications(token)` - Dapatkan semua permintaan verifikasi
- `getPendingVerifications(token)` - Dapatkan permintaan tertunda saja
- `approveVerification(token, id)` - Setujui pendaftaran penduduk
- `rejectVerification(token, id, reason)` - Tolak dengan alasan

**Endpoint API:**
- GET `/verification-warga` - Daftar semua permintaan verifikasi
- GET `/verification-warga/pending` - Permintaan tertunda
- POST `/verification-warga/submit` - Kirimkan pendaftaran untuk verifikasi
- PUT `/verification-warga/approve/{id}` - Setujui permintaan
- PUT `/verification-warga/reject/{id}` - Tolak permintaan

**Layanan Terkait:** VerificationWargaApiService (panggilan API tingkat rendah)

---

### Layanan Manajemen Pengguna (UserManagementService)

**Tujuan:** Manajemen akun pengguna tingkat sistem

**Metode Kunci:**
- `getAllUsers(token)` - Daftar semua pengguna sistem
- `getUserById(token, id)` - Dapatkan detail pengguna
- `createUser(token, data)` - Buat pengguna baru
- `updateUser(token, id, data)` - Perbarui informasi pengguna
- `deleteUser(token, id)` - Hapus akun pengguna
- `changeUserRole(token, id, newRole)` - Ubah peran pengguna

**Endpoint API:**
- GET `/user` - Daftar semua pengguna
- GET `/user/{id}` - Dapatkan detail pengguna
- POST `/user` - Buat pengguna
- PUT `/user/{id}` - Perbarui pengguna
- DELETE `/user/{id}` - Hapus pengguna

---

### Layanan Penyimpanan Pengguna (UserStorage)

**Tujuan:** Kelola persistensi lokal autentikasi dan data pengguna

**Metode Kunci:**
- `saveUserData(token, userData)` - Simpan informasi login
- `getToken()` - Ambil token JWT yang tersimpan
- `getUserData()` - Dapatkan informasi pengguna yang di-cache
- `getUserName()` - Dapatkan nama pengguna yang tersimpan
- `getUserEmail()` - Dapatkan email pengguna yang tersimpan
- `getUserRole()` - Dapatkan peran pengguna yang tersimpan
- `clearUserData()` - Hapus data tersimpan (logout)

**Penyimpanan:** SharedPreferences (penyimpanan lokal berbasis kunci)

---

### Layanan Manajemen Pendapatan (PemasukanService)

**Tujuan:** Menangani kategori biaya, penagihan, dan pelacakan pendapatan

**Metode Kunci:**
- `getKategoriIuran(token)` - Dapatkan semua kategori biaya
- `createKategoriIuran(token, data)` - Buat kategori baru
- `updateKategoriIuran(token, id, data)` - Perbarui kategori
- `generateTagihan(token, data)` - Buat faktur
- `getTagihan(token)` - Dapatkan semua faktur
- `getPemasukan(token)` - Dapatkan semua catatan pendapatan
- `markAsPaid(token, tagihanId)` - Tandai faktur sebagai dibayar

**Endpoint API:**
- GET `/kategori-iuran` - Daftar kategori
- POST `/kategori-iuran` - Buat kategori
- GET `/tagihan` - Daftar faktur
- POST `/tagihan/generate` - Buat faktur baru
- PUT `/tagihan/{id}/paid` - Tandai dibayar
- GET `/pemasukan` - Daftar pendapatan

---

### Layanan Pencatatan Aktivitas (ActivityLogService)

**Tujuan:** Catat dan ambil log aktivitas

**Metode Kunci:**
- `getAllActivityLogs(token)` - Dapatkan semua catatan aktivitas
- `getActivityLogsByUser(token, userId)` - Dapatkan aktivitas pengguna
- `getActivityLogsByDate(token, startDate, endDate)` - Dapatkan log berdasarkan rentang tanggal
- `logActivity(token, description)` - Catat aktivitas baru

**Penggunaan:** Jejak audit, riwayat administratif, pelacakan aktivitas

---

## Modul Inti

### **1. Modul Autentikasi**
- Login dan pendaftaran pengguna
- Manajemen token JWT
- Kontrol akses berbasis peran
- Persistensi sesi

### **2. Modul Manajemen Pengguna**
- Manajemen akun pengguna sistem
- Penugasan dan modifikasi peran
- Izin pengguna dan tingkat akses
- Pelacakan aktivitas pengguna

### **3. Modul Manajemen Penduduk (Warga)**
- Buat dan kelola catatan penduduk
- Pelacakan NIK (ID Nasional)
- Asosiasi keluarga
- Pelacakan status domisili dan kehidupan
- Proses pendaftaran mandiri

### **4. Modul Manajemen Keluarga (Keluarga)**
- Organisir penduduk ke dalam keluarga
- Penunjukan kepala keluarga
- Manajemen struktur keluarga
- Data sensus rumah tangga

### **5. Modul Manajemen Properti (Rumah)**
- Jaga registri properti
- Pelacakan status kepemilikan
- Asosiasi perumahan keluarga
- Informasi hunian

### **6. Modul Marketplace**
- Daftar marketplace penduduk
- Unggah gambar untuk produk
- Penelusuran dan penjelajahan produk
- Administrasi marketplace

### **7. Modul Transaksi**
- Pemrosesan pembelian marketplace
- Pelacakan riwayat transaksi
- Pembuatan tanda terima
- Pelaporan transaksi

### **8. Modul Manajemen Pendapatan (Pemasukan)**
- Definisi kategori biaya
- Pembuatan dan pelacakan faktur
- Manajemen pengumpulan pembayaran
- Pelaporan dan statistik pendapatan

### **9. Modul Verifikasi**
- Manajemen permintaan pendaftaran mandiri
- Proses persetujuan/penolakan penduduk
- Pelacakan status verifikasi
- Pengawasan admin

### **10. Modul Dashboard dan Pelaporan**
- Dashboard spesifik pengguna
- Statistik komunitas
- Pencatatan aktivitas dan pelaporan
- Tampilan informasi spesifik peran

---

## Stack Teknologi

### **Frontend**
- **Bahasa:** Dart
- **Framework:** Flutter
- **Minimum SDK:** Dart 3.0.0+
- **UI:** Material Design dengan tema ungu khusus

### **Navigasi & Routing**
- **GoRouter** (v17.0.0) - Deep linking dan routing deklaratif

### **Komunikasi HTTP & API**
- **http** (v1.2.2) - Panggilan API RESTful
- **URL Dasar:** `http://virtualtech.icu:3030`
- **Path API:** `/api`

### **Penyimpanan Lokal**
- **shared_preferences** (v2.2.2) - Penyimpanan lokal berbasis kunci-nilai

### **Komponen UI & Visualisasi**
- **material_design_icons** - Ikon Material Design
- **font_awesome_flutter** (v10.12.0) - Ikon FontAwesome
- **fl_chart** (v1.1.1) - Bagan dan grafik
- **data_table_2** (v2.6.0) - Tabel data canggih

### **Penanganan File & Media**
- **image_picker** (v1.2.0) - Pemilihan gambar dari perangkat
- **file_picker** (v10.3.3) - Pemilihan file untuk unggahan

### **Utilitas**
- **intl** (v0.19.0) - Pemformatan tanggal/waktu dan pelokalan

### **Backend**
- **Server API:** API RESTful
- **URL Server:** `http://virtualtech.icu:3030`
- **Autentikasi:** Token Bearer JWT

---

## Dukungan dan Dokumentasi

- **Dokumentasi Flutter:** https://docs.flutter.dev
- **Panduan GoRouter:** https://pub.dev/packages/go_router
- **Bahasa Dart:** https://dart.dev

Untuk masalah, permintaan fitur, atau kontribusi, silakan merujuk ke panduan proyek atau hubungi tim pengembangan.
