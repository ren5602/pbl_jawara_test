# Panduan Setup - Jawara Apps

Panduan lengkap untuk setup dan menjalankan proyek Flutter Jawara Apps.

**Daftar Isi**
- [Prasyarat](#prasyarat)
- [Setup Lingkungan](#setup-lingkungan)
- [Instalasi Proyek](#instalasi-proyek)
- [Konfigurasi](#konfigurasi)
- [Menjalankan Aplikasi](#menjalankan-aplikasi)
- [Pengujian](#pengujian)
- [Pemecahan Masalah](#pemecahan-masalah)
- [Lingkungan Pengembangan](#lingkungan-pengembangan)

---

## Prasyarat

Sebelum memulai, pastikan Anda telah menginstal yang berikut di sistem Anda:

### Persyaratan Sistem
- **Sistem Operasi:** Windows, macOS, atau Linux
- **RAM:** Minimum 4GB (8GB disarankan)
- **Penyimpanan:** Setidaknya 500MB ruang bebas untuk alat pengembangan

### Perangkat Lunak Wajib
1. **Git** - Sistem kontrol versi
   - Unduh: https://git-scm.com/downloads
   - Verifikasi instalasi: `git --version`

2. **Flutter SDK** - Versi stabil terbaru
   - Unduh: https://flutter.dev/docs/get-started/install
   - Versi minimum: Flutter 3.0.0
   - Termasuk Dart SDK secara otomatis

3. **Dart SDK** - Disertakan dengan Flutter
   - Verifikasi: `dart --version`
   - Versi minimum: Dart 3.0.0

4. **IDE/Editor Kode** - Salah satu dari:
   - **VS Code** (Direkomendasikan)
     - Instal ekstensi Flutter dan Dart
   - **Android Studio**
     - Instal plugin Flutter dan Dart
   - **IntelliJ IDEA**
     - Instal plugin Flutter dan Dart

5. **Persyaratan Spesifik Platform:**

   **Untuk Pengembangan Android:**
   - Android SDK (disertakan dengan Android Studio)
   - Level API Android 21 atau lebih tinggi
   - Emulator Android atau perangkat Android fisik (API 21+)

   **Untuk Pengembangan iOS (macOS saja):**
   - Xcode 13.0 atau lebih baru
   - CocoaPods: `sudo gem install cocoapods`
   - iOS Deployment Target: 11.0 atau lebih tinggi

6. **Akses Database/Backend:**
   - Akses ke server API di `http://virtualtech.icu:3030`
   - Konektivitas jaringan (untuk panggilan API)

---

## Setup Lingkungan

### 1. Instal Flutter

#### Di Windows
```
1. Unduh Flutter SDK dari https://flutter.dev/docs/get-started/install/windows
2. Ekstrak ke lokasi yang diinginkan (misalnya C:\flutter)
3. Tambahkan Flutter ke PATH:
   - Buka Variabel Lingkungan
   - Tambahkan C:\flutter\bin ke PATH
   - Restart terminal/IDE
4. Jalankan: flutter doctor
```

#### Di macOS
```
brew install flutter
flutter doctor
```

#### Di Linux
```
1. Unduh Flutter SDK
2. Ekstrak: tar xf flutter_linux_*.tar.xz
3. Tambahkan ke PATH di ~/.bashrc atau ~/.zshrc:
   export PATH="$PATH:/path/to/flutter/bin"
4. Jalankan: flutter doctor
```

### 2. Verifikasi Instalasi

Jalankan perintah berikut untuk memeriksa semua dependensi:
```bash
flutter doctor
```

Output yang diharapkan harus menampilkan:
- âœ“ Flutter (Channel stable)
- âœ“ Dart SDK (versi 3.x.x atau lebih tinggi)
- âœ“ Android toolchain (untuk pengembangan Android)
- âœ“ Xcode / Android Studio (untuk dukungan IDE)

### 3. Instal Ekstensi IDE

#### VS Code
1. Buka tab Ekstensi (Ctrl+Shift+X)
2. Cari dan instal:
   - "Flutter" (oleh Dart Code)
   - "Dart" (oleh Dart Code)
3. Muat ulang VS Code

#### Android Studio / IntelliJ
1. Buka Preferences/Settings > Plugins
2. Cari dan instal:
   - Flutter
   - Dart
3. Restart IDE

---

## Instalasi Proyek

### 1. Clone Repository

```bash
git clone <repository-url> pbl_jawara_test
cd pbl_jawara_test
```

Atau jika menggunakan salinan lokal yang ada:
```bash
cd d:\kuliah\SMT5\mobile\flutter_tester\pbl_jawara_test
```

### 2. Instal Dependensi Flutter

```bash
# Dapatkan semua dependensi proyek
flutter pub get

# Atau gunakan pub secara langsung
pub get
```

Ini akan:
- Unduh semua dependensi yang terdaftar di `pubspec.yaml`
- Buat file `.packages`
- Perbarui `pubspec.lock` dengan versi yang tepat

### 3. Verifikasi Struktur Proyek

Pastikan direktori berikut ada:
```
lib/              - Kode sumber
android/          - Kode platform Android
ios/              - Kode platform iOS
test/             - Tes unit
integration_test/ - Tes integrasi
pubspec.yaml      - Konfigurasi proyek
```

---

## Konfigurasi

### 1. Konfigurasi API

Endpoint API dikonfigurasi di [lib/config/api_config.dart](lib/config/api_config.dart).

**Konfigurasi Saat Ini:**
```
URL Dasar: http://virtualtech.icu:3030
Path API: /api
```

Jika Anda perlu mengubah server API:

1. Buka `lib/config/api_config.dart`
2. Perbarui variabel `baseUrl`:
   ```
   const String baseUrl = 'http://url-api-anda:port';
   ```
3. Simpan dan bangun ulang aplikasi

### 2. Konfigurasi Spesifik Platform

#### Konfigurasi Android
- Minimum API Level: 21
- Target API Level: 33+
- Dikonfigurasi di `android/app/build.gradle.kts`

#### Konfigurasi iOS
- Minimum Deployment Target: 11.0
- Dikonfigurasi di `ios/Podfile`

### 3. Konfigurasi Aset

Gambar, ikon, dan aset lainnya dikonfigurasi di `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
```

---

## Menjalankan Aplikasi

### 1. Pilih Platform Target

#### Jalankan di Emulator Android
```bash
# Daftar emulator yang tersedia
flutter emulators

# Jalankan emulator
flutter emulators --launch <emulator_name>

# Jalankan aplikasi
flutter run
```

#### Jalankan di Perangkat Android Fisik
```bash
# Aktifkan USB Debugging di perangkat
# Hubungkan perangkat melalui USB
# Verifikasi koneksi
flutter devices

# Jalankan aplikasi
flutter run
```

#### Jalankan di iOS Simulator (macOS)
```bash
# Mulai simulator
open -a Simulator

# Jalankan aplikasi
flutter run
```

#### Jalankan di Perangkat iOS Fisik (macOS)
```bash
# Hubungkan perangkat melalui USB
# Verifikasi koneksi
flutter devices

# Jalankan aplikasi
flutter run
```

### 2. Perintah Dasar

```bash
# Jalankan dalam mode debug (pengembangan)
flutter run

# Jalankan dalam mode release (dioptimalkan)
flutter run --release

# Jalankan dengan perangkat tertentu
flutter run -d <device_id>

# Jalankan dan biarkan aplikasi tetap berjalan (mode watch)
flutter run

# Hentikan aplikasi yang sedang berjalan
# Tekan 'q' di terminal
```

### 3. Hot Reload

Selama pengembangan dengan `flutter run`:
- Tekan `r` untuk hot reload (cepat, mempertahankan status)
- Tekan `R` untuk hot restart (restart penuh)
- Tekan `q` untuk keluar

---

## Pengujian

### 1. Jalankan Tes Unit

```bash
# Jalankan semua tes unit
flutter test

# Jalankan file tes tertentu
flutter test test/widget_test.dart

# Jalankan dengan output verbose
flutter test --verbose

# Buat laporan cakupan
flutter test --coverage
```

### 2. Jalankan Tes Integrasi

```bash
# Jalankan semua tes integrasi
flutter test integration_test/

# Jalankan tes integrasi tertentu
flutter test integration_test/login_test.dart

# Jalankan di perangkat fisik
flutter test integration_test/ -d <device_id>
```


## Pemecahan Masalah

### Masalah Umum dan Solusi

#### 1. Flutter Tidak Ditemukan
**Error:** `'flutter' is not recognized as an internal or external command`

**Solusi:**
- Pastikan Flutter ditambahkan ke PATH
- Verifikasi: `flutter doctor`
- Restart terminal/IDE

#### 2. Dependensi Tidak Terinstal
**Error:** `Error: Could not find the required version of the provider package`

**Solusi:**
```bash
flutter clean
flutter pub get
flutter run
```

#### 3. Build Android Gagal
**Error:** `Android SDK not found` atau `Gradle build failed`

**Solusi:**
```bash
flutter clean
cd android
./gradlew clean
cd ..
flutter run
```

#### 4. Build iOS Gagal (macOS)
**Error:** `Xcode build failed` atau `Pod install failed`

**Solusi:**
```bash
flutter clean
cd ios
rm -rf Pods
rm Podfile.lock
cd ..
flutter pub get
flutter run
```

#### 5. Masalah Koneksi API
**Error:** `Connection refused` atau `Network error`

**Solusi:**
- Verifikasi server API sedang berjalan: `ping virtualtech.icu`
- Periksa konektivitas internet
- Verifikasi konfigurasi API di `lib/config/api_config.dart`
- Periksa pengaturan firewall

#### 6. Port Sudah Digunakan (Emulator)
**Error:** `Port XXXX already in use`

**Solusi:**
```bash
# Matikan proses yang ada
# Di Windows: taskkill /PID <pid> /F
# Di macOS/Linux: kill -9 <pid>

flutter clean
flutter run
```

#### 7. Konflik Versi Paket
**Error:** `Version conflict in dependencies`

**Solusi:**
```bash
flutter pub get --no-offline
flutter pub upgrade
flutter clean
flutter run
```

---

## Lingkungan Pengembangan

### Ekstensi yang Direkomendasikan (VS Code)

1. **Flutter** - oleh Dart Code (Microsoft)
   - ID: Dart-Code.flutter
   - Menyediakan template dan snippet Flutter

2. **Dart** - oleh Dart Code (Microsoft)
   - ID: Dart-Code.dart-code
   - Dukungan bahasa Dart

3. **Awesome Flutter Snippets** - oleh Nash
   - Snippet kode Flutter yang cepat

4. **REST Client** - oleh Huachao Mao
   - Tes endpoint API langsung di editor

### Pengaturan yang Direkomendasikan (VS Code settings.json)

```json
{
  "editor.formatOnSave": true,
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": true
    },
    "editor.defaultFormatter": "Dart-Code.dart-code"
  },
  "dart.flutterHotReloadOnSave": "all",
  "dart.lineLength": 100
}
```

### Panduan Gaya Kode

- **Bahasa:** Dart
- **Gaya Kode:** Ikuti konvensi Dart
- **Panjang Baris:** 100 karakter
- **Pemformatan:** Gunakan `dart format`
- **Linting:** Ikuti `analysis_options.yaml`

### Perintah Pengembangan Berguna

```bash
# Format semua file Dart
dart format lib/

# Analisis kode untuk masalah
dart analyze

# Buat kode (jika menggunakan build_runner)
flutter pub run build_runner build

# Hapus cache build
flutter clean

# Periksa kesehatan proyek
flutter doctor

# Daftar semua perangkat yang tersedia
flutter devices

# Dapatkan informasi paket terperinci
flutter pub deps
```

---

## Database & Backend

### Informasi Server API

**URL Server:** `http://virtualtech.icu:3030`  
**Endpoint API:** `/api`  
**Autentikasi:** Bearer Token (JWT)

### Endpoint API Umum

```
Autentikasi:
- POST   /auth/login              - Login pengguna
- POST   /auth/register           - Pendaftaran pengguna
- GET    /auth/profile            - Dapatkan profil pengguna

Warga (Penduduk):
- GET    /warga                   - Daftar semua penduduk
- POST   /warga                   - Buat penduduk
- GET    /warga/{id}              - Dapatkan detail penduduk
- PUT    /warga/{id}              - Perbarui penduduk
- DELETE /warga/{id}              - Hapus penduduk

Keluarga (Keluarga):
- GET    /keluarga                - Daftar semua keluarga
- POST   /keluarga                - Buat keluarga
- GET    /keluarga/{id}           - Dapatkan detail keluarga
- PUT    /keluarga/{id}           - Perbarui keluarga
- DELETE /keluarga/{id}           - Hapus keluarga

Rumah (Properti):
- GET    /rumah                   - Daftar semua properti
- POST   /rumah                   - Buat properti
- GET    /rumah/{id}              - Dapatkan detail properti
- PUT    /rumah/{id}              - Perbarui properti
- DELETE /rumah/{id}              - Hapus properti

Marketplace:
- GET    /marketplace             - Daftar item
- POST   /marketplace             - Buat item (multipart)
- GET    /marketplace/{id}        - Dapatkan detail item
- PUT    /marketplace/{id}        - Perbarui item
- DELETE /marketplace/{id}        - Hapus item

Transaksi:
- GET    /transaction             - Daftar transaksi
- POST   /transaction/purchase    - Buat transaksi
- GET    /transaction/{id}        - Dapatkan detail transaksi

Verifikasi:
- GET    /verification-warga      - Daftar verifikasi
- POST   /verification-warga/submit    - Kirimkan untuk verifikasi
- PUT    /verification-warga/approve/{id}  - Setujui
- PUT    /verification-warga/reject/{id}   - Tolak
```

### Pengujian Endpoint API

Gunakan REST Client atau Postman:
1. Atur URL dasar ke `http://virtualtech.icu:3030`
2. Atur header: `Authorization: Bearer <token_anda>`
3. Atur header: `Content-Type: application/json`
4. Tes endpoint sesuai kebutuhan

---

## Build & Distribusi

### Buat Build Produksi

#### APK Android
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### App Bundle Android
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### iOS IPA (macOS)
```bash
flutter build ipa --release
# Output: build/ios/ipa/
```

---

## Sumber Daya Tambahan

### Dokumentasi Resmi
- Flutter Docs: https://flutter.dev/docs
- Dart Docs: https://dart.dev/guides
- GoRouter: https://pub.dev/packages/go_router

### Sumber Pembelajaran
- Flutter Codelab: https://flutter.dev/codelabs
- Dart Language Tour: https://dart.dev/guides/language/language-tour
- Flutter Cookbook: https://flutter.dev/docs/cookbook

### Komunitas
- Stack Overflow: Tag dengan `flutter` atau `dart`
- Reddit: r/FlutterDev
- Discord: Flutter Community

---

Untuk bantuan tambahan atau masalah yang tidak tercakup dalam panduan ini, silakan hubungi tim pengembangan atau lihat [README.md](README.md) utama.
