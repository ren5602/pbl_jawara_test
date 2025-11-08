import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogAktivitasSection extends StatelessWidget {
  const LogAktivitasSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Data dummy log: ikon + teks
    final logs = [
      {
        'icon': FontAwesomeIcons.userGroup,
        'text': 'User Aziz Berhasil Ditambah',
      },
      {
        'icon': FontAwesomeIcons.cartShopping,
        'text': 'Renhwa Memposting Barang Baru',
      },
      {
        'icon': FontAwesomeIcons.dollarSign,
        'text': 'Pemasukan Rp 50.000 berhasil ditambahkan',
      },
    ];

    const cardColor = Color(0xFF00B894); // warna hijau toska

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Log Aktivitas', style: theme.textTheme.titleLarge),
            Text(
              'Detail',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: cardColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // List log
        Column(
          children: logs.map((log) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 65, // ✅ tinggi seragam untuk semua item
              child: Row(
                children: [
                  // Kotak ikon
                  Container(
                    width: 65,
                    height: double.infinity, // ✅ biar sejajar penuh
                    decoration: const BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: FaIcon(
                        log['icon'] as IconData,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 6), // ✅ jarak antar kotak
                  // Kotak teks
                  Expanded(
                    child: Container(
                      height: double.infinity, // ✅ tinggi sama
                      decoration: const BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        log['text'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
