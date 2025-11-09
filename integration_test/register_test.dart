import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pbl_jawara_test/main.dart';
import 'package:integration_test/integration_test.dart';

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
      print('✅ Login page displayed');

      // Klik tombol "Daftar" untuk pindah ke halaman register
      final daftarButton = find.text('Daftar');
      await tester.tap(daftarButton);
      await tester.pumpAndSettle();
      // Pastikan halaman register tampil
      expect(find.text('Nama Lengkap'), findsOneWidget);
      print('✅ Register page displayed');

      // Cari widget berdasarkan key
      final nameField = find.byKey(const Key('nameField'));
      final emailField = find.byKey(const Key('emailField'));
      final passwordField = find.byKey(const Key('passwordField'));
      final registerButton = find.byKey(const Key('registerButton'));
      print('✅ Found input fields and register button');

      // Isi input field
      await tester.enterText(nameField, 'John Doe');
      await tester.enterText(emailField, 'user@example.com');
      await tester.enterText(passwordField, '123456');
      await tester.pumpAndSettle();
      print('✅ Entered name, email, password, and confirmed password');

      // Tekan tombol register
      await tester.ensureVisible(registerButton);
      await tester.pumpAndSettle();
      await tester.tap(registerButton);
      await tester.pumpAndSettle();
      print('✅ Tapped register button');

      // Verifikasi Snackbar muncul
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Registrasi berhasil!'), findsAtLeastNWidgets(1));
      print('✅ Snackbar tampil');
      print('🎉 All tests passed successfully');
    });
  });
}
