import 'package:flutter/material.dart';

class DashboardStatistikWidget extends StatelessWidget {
  const DashboardStatistikWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': Icons.attach_money, 'label': 'Keuangan'},
      {'icon': Icons.date_range_rounded, 'label': 'Kegiatan'},
      {'icon': Icons.people_alt_outlined, 'label': 'Kependudukan'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8)],
      ),
      padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard Statistik",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item['icon'] as IconData, color: Colors.teal),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['label'] as String,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
