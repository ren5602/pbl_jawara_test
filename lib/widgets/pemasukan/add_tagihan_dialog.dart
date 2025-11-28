import 'package:flutter/material.dart';

class AddTagihanDialog extends StatefulWidget {
  final Function(Map<String, String>) onTagihanAdded;

  const AddTagihanDialog({super.key, required this.onTagihanAdded});

  @override
  State<AddTagihanDialog> createState() => _AddTagihanDialogState();
}

class _AddTagihanDialogState extends State<AddTagihanDialog> {
  final TextEditingController _namaKeluargaController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _periodeController = TextEditingController();

  String? _selectedJenis;

  void _submitForm() {
    if (_namaKeluargaController.text.isEmpty ||
        _nominalController.text.isEmpty ||
        _selectedJenis == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi semua field"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newTagihan = {
      "namaKeluarga": _namaKeluargaController.text,
      "statusKeluarga": "Aktif",               // default
      "jenis": _selectedJenis!,               // Bulanan / Khusus
      "kodeTagihan": "IR${DateTime.now().millisecondsSinceEpoch}",
      "nominal": "Rp ${_nominalController.text}",
      "periode": _periodeController.text.isNotEmpty
          ? _periodeController.text
          : "Tidak Ada",
      "status": "Belum Lunas",                // DEFAULT BARU
    };

    widget.onTagihanAdded(newTagihan);
    _resetForm();
    Navigator.of(context).pop();
  }

  void _resetForm() {
    _namaKeluargaController.clear();
    _nominalController.clear();
    _periodeController.clear();
    _selectedJenis = null;
  }

  @override
  void dispose() {
    _namaKeluargaController.dispose();
    _nominalController.dispose();
    _periodeController.dispose();
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
            "Buat Tagihan Iuran Baru",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Masukkan data tagihan iuran baru.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNamaKeluargaField(),
            const SizedBox(height: 16),
            _buildJenisDropdown(),
            const SizedBox(height: 16),
            _buildNominalField(),
            const SizedBox(height: 16),
            _buildPeriodeField(),
          ],
        ),
      ),
      actions: [_buildCancelButton(), _buildSaveButton()],
    );
  }

  Widget _buildNamaKeluargaField() {
    return TextField(
      controller: _namaKeluargaController,
      decoration: InputDecoration(
        labelText: "Nama Keluarga",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildJenisDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedJenis,
      decoration: InputDecoration(
        labelText: "Jenis Iuran",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: const [
        DropdownMenuItem(value: "Bulanan", child: Text("Iuran Bulanan")),
        DropdownMenuItem(value: "Khusus", child: Text("Iuran Khusus")),
      ],
      onChanged: (value) {
        setState(() {
          _selectedJenis = value;
        });
      },
    );
  }

  Widget _buildNominalField() {
    return TextField(
      controller: _nominalController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Nominal Iuran",
        hintText: "contoh: 10000",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildPeriodeField() {
    return TextField(
      controller: _periodeController,
      decoration: InputDecoration(
        labelText: "Periode (opsional)",
        hintText: "contoh: 2 Januari 2023",
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
