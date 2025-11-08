import 'package:flutter/material.dart';

class KegiatanSection extends StatelessWidget {
  const KegiatanSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ✅ Dummy data kegiatan
    final kegiatanList = [
      {
        'judul': 'Muncak Bromo',
        'tanggal': '29 November 2025',
        'gambar':
            'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=871',
      },
      {
        'judul': 'Touring Warga',
        'tanggal': '29 Desember 2025',
        'gambar':
            'https://images.unsplash.com/photo-1551632811-561732d1e306?auto=format&fit=crop&w=800&q=80',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kegiatan Warga', style: theme.textTheme.titleLarge),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Kegiatan Terbaru', style: theme.textTheme.bodyMedium),
            Text(
              'Detail',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Color(0xFF00B894),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // ✅ List kegiatan
        Column(
          children: kegiatanList.map((kegiatan) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      kegiatan['gambar']!,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Overlay hijau transparan
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal.withOpacity(0.75),
                          Colors.teal.withOpacity(0.75),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),

                  // Teks kegiatan
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kegiatan['judul']!,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          kegiatan['tanggal']!,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
