import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class IuranTable extends StatelessWidget {
  final List<Map<String, String>> pemasukanData;
  final VoidCallback onAddPressed;
  final Function(Map<String, String>) onDeletePressed;
  final Function(Map<String, String>) onViewPressed;

  const IuranTable({
    super.key,
    required this.pemasukanData,
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
        _buildDataTable(theme, colorScheme),
      ],
    );
  }

  Widget _buildTableHeader(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Daftar Pemasukan",
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

  Widget _buildDataTable(ThemeData theme, ColorScheme colorScheme) {
    return Expanded(
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 300,
        headingRowColor: MaterialStateProperty.all(
          theme.colorScheme.primary.withOpacity(0.1),
        ),
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.secondary,
        ),
        columns: const [
          DataColumn2(label: Text('No'), size: ColumnSize.S),
          DataColumn2(label: Text('Nama'), size: ColumnSize.L),
          DataColumn2(label: Text('Jenis'), size: ColumnSize.M),
          DataColumn2(label: Text('Tanggal'), size: ColumnSize.M),
          DataColumn2(label: Text('Nominal'), numeric: true, size: ColumnSize.L),
          DataColumn2(label: Text('Aksi'), size: ColumnSize.S),
        ],
        rows: pemasukanData.map((item) {
          return DataRow2(
            onTap: () => onViewPressed(item),
            cells: [
              DataCell(Text(item['no']!)),
              DataCell(Text(item['nama']!)),
              DataCell(Text(item['jenis']!)),
              DataCell(Text(item['tanggal']!)),
              DataCell(
                Text(
                  item['nominal']!,
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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