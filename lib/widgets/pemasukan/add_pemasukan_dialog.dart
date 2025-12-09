import 'package:flutter/material.dart';

class AddPemasukanDialog extends StatefulWidget {
  final Function(Map<String, String>) onPemasukanAdded;

  const AddPemasukanDialog({super.key, required this.onPemasukanAdded});

  @override
  State<AddPemasukanDialog> createState() => _AddPemasukanDialogState();
}

class _AddPemasukanDialogState extends State<AddPemasukanDialog> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  String? _selectedJenis;

  void _submitForm() {
    if (_namaController.text.isEmpty ||
        _nominalController.text.isEmpty ||
        _selectedJenis == null ||
        _tanggalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi semua field"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newPemasukan = {
      "nama": _namaController.text,
      "jenis": _selectedJenis!,
      "tanggal": _tanggalController.text,
      "nominal": "Rp ${_nominalController.text}",
    };

    widget.onPemasukanAdded(newPemasukan);
    _resetForm();
    Navigator.of(context).pop();
  }

  void _resetForm() {
    _namaController.clear();
    _nominalController.clear();
    _tanggalController.clear();
    _selectedJenis = null;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nominalController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tambah Pemasukan Baru",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Masukkan data pemasukan baru.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNamaField(),
            const SizedBox(height: 16),
            _buildJenisDropdown(),
            const SizedBox(height: 16),
            _buildTanggalField(),
            const SizedBox(height: 16),
            _buildNominalField(),
          ],
        ),
      ),
      actions: [_buildCancelButton(), _buildSaveButton()],
    );
  }

  Widget _buildNamaField() {
    return TextField(
      controller: _namaController,
      decoration: InputDecoration(
        labelText: "Nama Pemasukan",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildJenisDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedJenis,
      decoration: InputDecoration(
        labelText: "Jenis Pemasukan",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: const [
        DropdownMenuItem(value: "Iuran", child: Text("Iuran")),
        DropdownMenuItem(value: "Sumbangan", child: Text("Sumbangan")),
        DropdownMenuItem(value: "Sewa Aset", child: Text("Sewa Aset")),
      ],
      onChanged: (value) {
        setState(() {
          _selectedJenis = value;
        });
      },
    );
  }

  Widget _buildTanggalField() {
    return TextField(
      controller: _tanggalController,
      decoration: InputDecoration(
        labelText: "Tanggal",
        hintText: "contoh: 15 Okt 2025",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildNominalField() {
    return TextField(
      controller: _nominalController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Nominal Pemasukan",
        hintText: "contoh: 500000",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _resetForm();
      },
      child: Text("Batal", style: TextStyle(color: Colors.grey[600])),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text("Simpan", style: TextStyle(color: Colors.white)),
    );
  }
}