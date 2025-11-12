import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../widgets/pemasukan/add_iuran_dialog.dart';
import '../../widgets/pemasukan/iuran_table.dart';
import '../../theme/AppTheme.dart';

class KategoriIuran extends StatefulWidget {
  const KategoriIuran({super.key});

  @override
  State<KategoriIuran> createState() => _KategoriIuranState();
}

class _KategoriIuranState extends State<KategoriIuran> {
  // Data dummy tanpa tanggal
  final List<Map<String, String>> _kategoriIuran = [
    {
      "no": "1",
      "nama": "Iuran Warga",
      "jenis": "Iuran Bulanan",
      "nominal": "Rp 10.000",
    },
    {
      "no": "2",
      "nama": "Sumbangan Acara",
      "jenis": "Iuran Khusus",
      "nominal": "Rp 20.000",
    },
    {
      "no": "3",
      "nama": "Sewa Lapangan",
      "jenis": "Iuran Khusus",
      "nominal": "Rp 10.000",
    },
  ];

  void _showAddIuranDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddIuranDialog(
          onIuranAdded: (newIuran) {
            _addNewIuran(newIuran);
          },
        );
      },
    );
  }

  void _addNewIuran(Map<String, String> newIuran) {
    setState(() {
      _kategoriIuran.add({
        "no": (_kategoriIuran.length + 1).toString(),
        "nama": newIuran['nama']!,
        "jenis": newIuran['jenis']!,
        "nominal": newIuran['nominal'] ?? "Rp 0",
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Iuran ${newIuran['nama']} berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteIuran(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Hapus Iuran"),
          content: Text("Yakin ingin menghapus iuran ${item['nama']}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _kategoriIuran.remove(item);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Iuran ${item['nama']} berhasil dihapus"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Hapus", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Iuran"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/menu-pemasukan'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header daftar + tombol tambah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Kategori Iuran",
                  style: theme.textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: _showAddIuranDialog,
                  child: const Text("Tambah"),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Daftar iuran
            Expanded(
              child: ListView.builder(
                itemCount: _kategoriIuran.length,
                itemBuilder: (context, index) {
                  final item = _kategoriIuran[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.warnaPrimary, // pakai warna dari AppTheme
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nama dan jenis
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nama'] ?? '-',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['jenis'] ?? '-',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        // Tombol detail
                        TextButton(
                          onPressed: () =>
                              context.push('/detail-kategori', extra: item),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            "Detail",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}