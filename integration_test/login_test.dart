import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_test/main.dart';
import 'package:integration_test/integration_test.dart';
// import 'package:pbl_jawara_test/pages/auth/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Integration Test', () {
    testWidgets('User can login successfully from main.dart',
        (WidgetTester tester) async {
      // Jalankan aplikasi dari main.dart
      print('✅ Start test');
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      print('✅ App loaded');

      // Pastikan halaman login tampil
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      print('✅ Login page displayed');
      // Cari widget berdasarkan key
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final loginButton = find.byKey(const Key('loginButton'));
      print('✅ Found input fields and login button');

      // Isi input field
      await tester.enterText(emailField, 'user@example.com');
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();
      print('✅ Entered email and password');

      // Tekan tombol login
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      print('✅ Tapped login button');

      // Verifikasi Snackbar muncul
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Login Berhasil!'), findsOneWidget);
      print('✅ Snackbar tampil');

      // Tunggu navigasi ke halaman Home
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verifikasi bahwa halaman HomeDashboardPage telah tampil
      // Sesuaikan teks di bawah dengan yang unik di halaman home_dashboard_page.dart
      expect(
          find.textContaining('Dashboard', findRichText: true), findsWidgets);
      print('✅ Navigated to HomeDashboardPage');

      print('🎉 All tests passed successfully');

      // Verifikasi navigasi ke halaman Home (bisa ubah sesuai konten HomeDashboardPage)
      // expect(find.text('Home'),
      //     findsWidgets); // asumsi ada teks 'Home' di halaman home
    });
  });
}
