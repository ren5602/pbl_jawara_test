import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/pemasukan/add_pemasukan_dialog.dart';
import '../../theme/AppTheme.dart';

class DaftarPemasukan extends StatefulWidget {
  const DaftarPemasukan({super.key});

  @override
  State<DaftarPemasukan> createState() => _DaftarPemasukanState();
}

class _DaftarPemasukanState extends State<DaftarPemasukan> {
  final List<Map<String, String>> _daftarPemasukan = [
    {
      "no": "1",
      "nama": "Iuran Warga",
      "jenis": "Iuran",
      "tanggal": "15 Okt 2025",
      "nominal": "Rp 500.000",
    },
    {
      "no": "2",
      "nama": "Sumbangan Acara",
      "jenis": "Sumbangan",
      "tanggal": "14 Okt 2025",
      "nominal": "Rp 750.000",
    },
    {
      "no": "3",
      "nama": "Sewa Lapangan",
      "jenis": "Sewa Aset",
      "tanggal": "12 Okt 2025",
      "nominal": "Rp 300.000",
    },
  ]; 

  void _showAddPemasukanDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddPemasukanDialog(
          onPemasukanAdded: (newPemasukan) {
            _addNewPemasukan(newPemasukan);
          },
        );
      },
    );
  }

  void _addNewPemasukan(Map<String, String> newPemasukan) {
    setState(() {
      _daftarPemasukan.add({
        "no": (_daftarPemasukan.length + 1).toString(),
        ...newPemasukan,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Pemasukan ${newPemasukan['namaKeluarga']} berhasil ditambahkan"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deletePemasukan(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Pemasukan"),
          content: Text("Yakin ingin menghapus pemasukan ${item['namaKeluarga']}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _daftarPemasukan.remove(item);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Pemasukan ${item['namaKeluarga']} berhasil dihapus"),
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
        title: const Text("Daftar Pemasukan"),
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
                  "Daftar Pemasukan",
                  style: theme.textTheme.titleLarge,
                ),
                ElevatedButton(
                  onPressed: _showAddPemasukanDialog,
                  child: const Text("Tambah"),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                itemCount: _daftarPemasukan.length,
                itemBuilder: (context, index) {
                  final item = _daftarPemasukan[index];
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
                        TextButton(
                          onPressed: () =>
                              context.push('/detail-pemasukan', extra: item),
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
