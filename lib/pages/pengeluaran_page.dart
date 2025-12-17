import 'package:flutter/material.dart';
import 'package:pbl_jawara_test/data/dummy_pengeluaran.dart';
import 'package:pbl_jawara_test/utils/user_storage.dart';

class PengeluaranPage extends StatefulWidget {
  const PengeluaranPage({super.key});

  @override
  State<PengeluaranPage> createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  late Future<bool> _isAdminFuture;
  List<Map<String, dynamic>> _pengeluaranList = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _isAdminFuture = _checkUserRole();
    _loadPengeluaranData();
  }

  Future<bool> _checkUserRole() async {
    final role = await UserStorage.getUserRole();
    return role == 'adminSistem' || role == 'ketuaRT' || role == 'ketuaRW';
  }

  Future<void> _loadPengeluaranData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _pengeluaranList = List.from(dummyPengeluaran);
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await _loadPengeluaranData();
  }

  void _showAddPengeluaranForm() {
    final namaController = TextEditingController();
    final deskripsiController = TextEditingController();
    final jumlahController = TextEditingController();
    String selectedKategori = 'Operasional';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah Pengeluaran Baru',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00B894),
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pengeluaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.money_off,
                      color: Color(0xFF00B894)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah (Rp)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon:
                      const Icon(Icons.attach_money, color: Color(0xFF00B894)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Pengeluaran',
                  hintText: 'Jelaskan pengeluaran dengan detail...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description,
                      color: Color(0xFF00B894)),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) =>
                    DropdownButtonFormField<String>(
                  value: selectedKategori,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.category,
                        color: Color(0xFF00B894)),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Operasional',
                        child: Text('Operasional')),
                    DropdownMenuItem(
                        value: 'Pemeliharaan',
                        child: Text('Pemeliharaan')),
                    DropdownMenuItem(value: 'Sosial', child: Text('Sosial')),
                    DropdownMenuItem(
                        value: 'Lain-lain', child: Text('Lain-lain')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedKategori = value ?? 'Operasional';
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B894),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (namaController.text.isEmpty ||
                        deskripsiController.text.isEmpty ||
                        jumlahController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Semua field harus diisi')),
                      );
                      return;
                    }

                    final newPengeluaran = {
                      'id': _pengeluaranList.length + 1,
                      'nama_pengeluaran': namaController.text,
                      'deskripsi': deskripsiController.text,
                      'kategori': selectedKategori,
                      'jumlah': int.tryParse(jumlahController.text) ?? 0,
                      'tanggal': DateTime.now().toString().split(' ')[0],
                      'status': 'Proses',
                    };

                    setState(() {
                      _pengeluaranList.insert(0, newPengeluaran);
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengeluaran berhasil ditambahkan'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'Tambah Pengeluaran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailPengeluaran(Map<String, dynamic> pengeluaran) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Pengeluaran',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00B894),
                    ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Nama Pengeluaran',
                  pengeluaran['nama_pengeluaran']?.toString() ?? '-'),
              const SizedBox(height: 16),
              _buildDetailRow(
                  'Jumlah',
                  'Rp ${_formatPrice(pengeluaran['jumlah']?.toString() ?? "0")}'),
              const SizedBox(height: 16),
              _buildDetailRow(
                  'Kategori',
                  pengeluaran['kategori']?.toString() ?? '-'),
              const SizedBox(height: 16),
              _buildDetailRow(
                  'Tanggal', pengeluaran['tanggal']?.toString() ?? '-'),
              const SizedBox(height: 16),
              _buildDetailRow(
                  'Status', pengeluaran['status']?.toString() ?? '-'),
              const SizedBox(height: 20),
              Text(
                'Deskripsi',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                pengeluaran['deskripsi']?.toString() ?? '-',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _showEditPengeluaranForm(Map<String, dynamic> pengeluaran) {
    final namaController =
        TextEditingController(text: pengeluaran['nama_pengeluaran']);
    final deskripsiController =
        TextEditingController(text: pengeluaran['deskripsi']);
    final jumlahController = TextEditingController(
        text: pengeluaran['jumlah']?.toString() ?? '0');
    String selectedKategori =
        pengeluaran['kategori'] ?? 'Operasional';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Pengeluaran',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00B894),
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pengeluaran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.money_off,
                      color: Color(0xFF00B894)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Jumlah (Rp)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon:
                      const Icon(Icons.attach_money, color: Color(0xFF00B894)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Pengeluaran',
                  hintText: 'Jelaskan pengeluaran dengan detail...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description,
                      color: Color(0xFF00B894)),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) =>
                    DropdownButtonFormField<String>(
                  value: selectedKategori,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.category,
                        color: Color(0xFF00B894)),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Operasional',
                        child: Text('Operasional')),
                    DropdownMenuItem(
                        value: 'Pemeliharaan',
                        child: Text('Pemeliharaan')),
                    DropdownMenuItem(value: 'Sosial', child: Text('Sosial')),
                    DropdownMenuItem(
                        value: 'Lain-lain', child: Text('Lain-lain')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedKategori = value ?? 'Operasional';
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B894),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (namaController.text.isEmpty ||
                        deskripsiController.text.isEmpty ||
                        jumlahController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Semua field harus diisi')),
                      );
                      return;
                    }

                    setState(() {
                      pengeluaran['nama_pengeluaran'] = namaController.text;
                      pengeluaran['deskripsi'] = deskripsiController.text;
                      pengeluaran['kategori'] = selectedKategori;
                      pengeluaran['jumlah'] =
                          int.tryParse(jumlahController.text) ?? 0;
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pengeluaran berhasil diperbarui'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleDelete(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menghapus pengeluaran ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _pengeluaranList.removeWhere((item) => item['id'] == id);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengeluaran berhasil dihapus'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  List<Map<String, dynamic>> _getFilteredPengeluaranList() {
    if (_selectedFilter == 'all') {
      return _pengeluaranList;
    }
    return _pengeluaranList
        .where((pengeluaran) =>
            pengeluaran['status'] == _selectedFilter)
        .toList();
  }

  void _changeFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _changeStatus(Map<String, dynamic> pengeluaran, String newStatus) {
    setState(() {
      pengeluaran['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status berhasil diubah menjadi $newStatus'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.green;
      case 'Proses':
      default:
        return Colors.orange;
    }
  }

  Color _getKategoryColor(String kategori) {
    switch (kategori) {
      case 'Operasional':
        return Colors.blue;
      case 'Pemeliharaan':
        return Colors.brown;
      case 'Sosial':
        return Colors.purple;
      case 'Lain-lain':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _formatPrice(String price) {
    try {
      final number = int.parse(price);
      return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
    } catch (e) {
      return price;
    }
  }

  Widget _buildPengeluaranCard(Map<String, dynamic> pengeluaran, bool isAdmin) {
    return GestureDetector(
      onTap: () => _showDetailPengeluaran(pengeluaran),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      pengeluaran['nama_pengeluaran'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00B894),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(pengeluaran['status'])
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pengeluaran['status'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(pengeluaran['status']),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Rp ${_formatPrice(pengeluaran['jumlah']?.toString() ?? "0")}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                pengeluaran['deskripsi'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getKategoryColor(pengeluaran['kategori'])
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      pengeluaran['kategori'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getKategoryColor(pengeluaran['kategori']),
                      ),
                    ),
                  ),
                  Text(
                    pengeluaran['tanggal'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              if (isAdmin) ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatusButton(
                              'Proses',
                              Colors.orange,
                              Icons.hourglass_empty,
                              () => _changeStatus(pengeluaran, 'Proses'),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _buildStatusButton(
                              'Selesai',
                              Colors.green,
                              Icons.check_circle,
                              () => _changeStatus(pengeluaran, 'Selesai'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildIconButton(
                              Icons.edit,
                              const Color(0xFF00B894),
                              () => _showEditPengeluaranForm(pengeluaran),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: _buildIconButton(
                              Icons.delete,
                              Colors.red,
                              () => _handleDelete(pengeluaran['id']),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusButton(
      String label, Color color, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.15),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Icon(icon, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isAdminFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pengeluaran'),
              backgroundColor: const Color(0xFF00B894),
              centerTitle: true,
              elevation: 2,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final isAdmin = snapshot.data ?? false;
        final filteredList = _getFilteredPengeluaranList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Pengeluaran',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF00B894),
            centerTitle: true,
            elevation: 2,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Column(
            children: [
              // Filter Chips
              Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      _buildFilterChip('Semua', 'all'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Proses', 'Proses'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Selesai', 'Selesai'),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),

              // Content
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Memuat pengeluaran...',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshData,
                        color: const Color(0xFF00B894),
                        child: filteredList.isEmpty
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 80),
                                        Icon(Icons.money_off,
                                            size: 80, color: Colors.grey[400]),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Belum ada pengeluaran',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[600]),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _selectedFilter == 'all'
                                              ? 'Mulai tambahkan pengeluaran'
                                              : 'Tidak ada pengeluaran dengan status $_selectedFilter',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: filteredList.length,
                                itemBuilder: (context, index) {
                                  return _buildPengeluaranCard(
                                    filteredList[index],
                                    isAdmin,
                                  );
                                },
                              ),
                      ),
              ),
            ],
          ),
          floatingActionButton: isAdmin
              ? FloatingActionButton(
                  onPressed: _showAddPengeluaranForm,
                  backgroundColor: const Color(0xFF00B894),
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          _changeFilter(value);
        }
      },
      backgroundColor: Colors.grey[200],
      selectedColor: const Color(0xFF00B894),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Colors.white,
    );
  }
}
