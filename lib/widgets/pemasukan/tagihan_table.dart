import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class TagihanTable extends StatelessWidget {
  final List<Map<String, String>> daftarTagihan;
  final VoidCallback onAddPressed;
  final Function(Map<String, String>) onDeletePressed;
  final Function(Map<String, String>) onViewPressed;

  const TagihanTable({
    super.key,
    required this.daftarTagihan,
    required this.onAddPressed,
    required this.onDeletePressed,
    required this.onViewPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        _buildTableHeader(theme, colorScheme),
        const SizedBox(height: 16),
        _buildDataTable(theme),
      ],
    );
  }

  Widget _buildTableHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Daftar Tagihan",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onAddPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("Tambah", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildDataTable(ThemeData theme) {
    return Expanded(
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 500,
        headingRowColor:
            MaterialStateProperty.all(theme.colorScheme.primary.withOpacity(0.1)),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.secondary,
        ),
        columns: const [
          DataColumn2(label: Text('No'), size: ColumnSize.S),
          DataColumn2(label: Text('Nama Keluarga'), size: ColumnSize.L),
          DataColumn2(label: Text('Nominal'), numeric: true, size: ColumnSize.L),
          DataColumn2(label: Text('Status'), size: ColumnSize.M),
          DataColumn2(label: Text('Aksi'), size: ColumnSize.S),
        ],
        rows: daftarTagihan.map((item) {
          return DataRow2(
            cells: [
              DataCell(Text(item['no']!)),
              DataCell(Text(item['namaKeluarga']!)),
              DataCell(
                Text(
                  item['nominal']!,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataCell(Text(item['status']!)),
              DataCell(_buildActionButtons(item, theme)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButtons(Map<String, String> item, ThemeData theme) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove_red_eye, size: 20, color: theme.colorScheme.primary),
          onPressed: () => onViewPressed(item),
        ),
        IconButton(
          icon: Icon(Icons.delete, size: 20, color: Colors.red),
          onPressed: () => onDeletePressed(item),
        ),
      ],
    );
  }
}
