import 'package:flutter/material.dart';
import 'package:pbl_jawara_test/data/dummy_aspirasi.dart';
import 'package:pbl_jawara_test/utils/user_storage.dart';

class AspirasiPage extends StatefulWidget {
  const AspirasiPage({super.key});

  @override
  State<AspirasiPage> createState() => _AspirasiPageState();
}

class _AspirasiPageState extends State<AspirasiPage> {
  late Future<bool> _isAdminFuture;
  List<Map<String, dynamic>> _aspirasiList = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _isAdminFuture = _checkUserRole();
    _loadAspirasiData();
  }

  Future<bool> _checkUserRole() async {
    final role = await UserStorage.getUserRole();
    return role == 'adminSistem' || role == 'ketuaRT' || role == 'ketuaRW';
  }

  Future<void> _loadAspirasiData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _aspirasiList = List.from(dummyAsparasi);
      _isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() => _isLoading = true);
    await _loadAspirasiData();
  }

  void _showAddAspirasiForm() {
    final namaController = TextEditingController();
    final deskripsiController = TextEditingController();
    String selectedKategori = 'Infrastruktur';

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
                'Ajukan Aspirasi Baru',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF00B894),
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Pengusul',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon:
                      const Icon(Icons.person, color: Color(0xFF00B894)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Deskripsi Aspirasi',
                  hintText: 'Jelaskan aspirasi Anda dengan detail...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon:
                      const Icon(Icons.description, color: Color(0xFF00B894)),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (context, setState) => DropdownButtonFormField<String>(
                  value: selectedKategori,
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon:
                        const Icon(Icons.category, color: Color(0xFF00B894)),
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: 'Infrastruktur', child: Text('Infrastruktur')),
                    DropdownMenuItem(
                        value: 'Keamanan', child: Text('Keamanan')),
                    DropdownMenuItem(
                        value: 'Kebersihan', child: Text('Kebersihan')),
                    DropdownMenuItem(
                        value: 'Fasilitas', child: Text('Fasilitas')),
                    DropdownMenuItem(value: 'Sosial', child: Text('Sosial')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedKategori = value ?? 'Infrastruktur';
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
                        deskripsiController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Semua field harus diisi')),
                      );
                      return;
                    }

                    final newAspirasi = {
                      'id': _aspirasiList.length + 1,
                      'nama_pengusul': namaController.text,
                      'deskripsi': deskripsiController.text,
                      'kategori': selectedKategori,
                      'tanggal': DateTime.now().toString().split(' ')[0],
                      'status': 'Pending',
                    };

                    setState(() {
                      _aspirasiList.insert(0, newAspirasi);
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Aspirasi berhasil ditambahkan'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'Ajukan Aspirasi',
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

  List<Map<String, dynamic>> _getFilteredAspirasiList() {
    if (_selectedFilter == 'all') {
      return _aspirasiList;
    }
    return _aspirasiList
        .where((aspirasi) => aspirasi['status'] == _selectedFilter)
        .toList();
  }

  void _changeFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  void _changeStatus(Map<String, dynamic> aspirasi, String newStatus) {
    setState(() {
      aspirasi['status'] = newStatus;
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
      case 'Diterima':
        return Colors.green;
      case 'Ditolak':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  Color _getKategoryColor(String kategori) {
    switch (kategori) {
      case 'Infrastruktur':
        return Colors.blue;
      case 'Keamanan':
        return Colors.red;
      case 'Kebersihan':
        return Colors.green;
      case 'Fasilitas':
        return Colors.purple;
      case 'Sosial':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  Widget _buildAspirasiCard(Map<String, dynamic> aspirasi, bool isAdmin) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    aspirasi['nama_pengusul'],
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
                    color: _getStatusColor(aspirasi['status']).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    aspirasi['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(aspirasi['status']),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              aspirasi['deskripsi'],
              maxLines: 3,
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
                    color: _getKategoryColor(aspirasi['kategori'])
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    aspirasi['kategori'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getKategoryColor(aspirasi['kategori']),
                    ),
                  ),
                ),
                Text(
                  aspirasi['tanggal'],
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatusButton(
                    'Pending',
                    Colors.orange,
                    () => _changeStatus(aspirasi, 'Pending'),
                  ),
                  _buildStatusButton(
                    'Diterima',
                    Colors.green,
                    () => _changeStatus(aspirasi, 'Diterima'),
                  ),
                  _buildStatusButton(
                    'Ditolak',
                    Colors.red,
                    () => _changeStatus(aspirasi, 'Ditolak'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withOpacity(0.2),
            foregroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
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
              title: const Text('Aspirasi'),
              backgroundColor: const Color(0xFF00B894),
              centerTitle: true,
              elevation: 2,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final isAdmin = snapshot.data ?? false;
        final filteredList = _getFilteredAspirasiList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Aspirasi',
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
                      _buildFilterChip('Pending', 'Pending'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Diterima', 'Diterima'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Ditolak', 'Ditolak'),
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
                            Text('Memuat aspirasi...',
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
                                        Icon(Icons.lightbulb_outline,
                                            size: 80, color: Colors.grey[400]),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Belum ada aspirasi',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[600]),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _selectedFilter == 'all'
                                              ? 'Mulai ajukan aspirasi Anda'
                                              : 'Tidak ada aspirasi dengan status $_selectedFilter',
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
                                  return _buildAspirasiCard(
                                    filteredList[index],
                                    isAdmin,
                                  );
                                },
                              ),
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showAddAspirasiForm,
            backgroundColor: const Color(0xFF00B894),
            child: const Icon(Icons.add),
          ),
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
