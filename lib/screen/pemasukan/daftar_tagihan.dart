import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/pemasukan/tagihan_table.dart';
import '../../widgets/pemasukan/add_tagihan_dialog.dart';
import '../../theme/AppTheme.dart';

class DaftarTagihan extends StatefulWidget {
  const DaftarTagihan({super.key});

  @override
  State<DaftarTagihan> createState() => _DaftarTagihanState();
}

class _DaftarTagihanState extends State<DaftarTagihan> {
  final List<Map<String, String>> _daftarTagihan = [
    {
      "no": "1",
      "namaKeluarga": "Keluarga Aziz",
      "statusKeluarga": "Aktif",
      "jenis": "Bulanan",
      "kodeTagihan": "IR12345",
      "nominal": "Rp 10.000",
      "periode": "2 Januari 2023",
      "status": "Belum Lunas",
    },
    {
      "no": "2",
      "namaKeluarga": "Keluarga Hilmi",
      "statusKeluarga": "Aktif",
      "jenis": "Bulanan",
      "kodeTagihan": "IR12346",
      "nominal": "Rp 10.000",
      "periode": "2 Januari 2023",
      "status": "Belum Lunas",
    },
    {
      "no": "3",
      "namaKeluarga": "Keluarga Dio",
      "statusKeluarga": "Aktif",
      "jenis": "Bulanan",
      "kodeTagihan": "IR12347",
      "nominal": "Rp 10.000",
      "periode": "2 Januari 2023",
      "status": "Belum Lunas",
    },
  ];

  void _showAddTagihanDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTagihanDialog(
          onTagihanAdded: (newTagihan) {
            _addNewTagihan(newTagihan);
          },
        );
      },
    );
  }

  void _addNewTagihan(Map<String, String> newTagihan) {
    setState(() {
      _daftarTagihan.add({
        "no": (_daftarTagihan.length + 1).toString(),
        ...newTagihan,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tagihan ${newTagihan['namaKeluarga']} berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteTagihan(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Tagihan"),
          content: Text("Yakin ingin menghapus tagihan ${item['namaKeluarga']}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _daftarTagihan.remove(item);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Tagihan ${item['namaKeluarga']} berhasil dihapus"),
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
        title: const Text("Tagihan Iuran"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Daftar Tagihan Iuran",
                  style: theme.textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: _showAddTagihanDialog,
                  child: const Text("Tambah"),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: _daftarTagihan.length,
                itemBuilder: (context, index) {
                  final item = _daftarTagihan[index];
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
                              item['namaKeluarga'] ?? '-',
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
                        TextButton(
                          onPressed: () =>
                              context.push('/detail-tagihan', extra: item),
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
