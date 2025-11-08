import 'package:flutter/material.dart';
import 'package:pbl_jawara_test/widgets/home/dashboard_header.dart';
import 'package:pbl_jawara_test/widgets/home/dashboard_statistik_widget.dart';
import 'package:pbl_jawara_test/widgets/home/kegiatan_section.dart';
import 'package:pbl_jawara_test/widgets/home/log_aktivitas_section.dart';
import 'package:pbl_jawara_test/widgets/bottom_navbar_widget.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavbarWidget(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),
                const SizedBox(height: 24),
                const DashboardStatistikWidget(),
                const SizedBox(height: 24),
                const KegiatanSection(),
                const SizedBox(height: 24),
                const LogAktivitasSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Row(
  //     children: [
  //       const CircleAvatar(
  //         radius: 22,
  //         backgroundColor: Colors.teal,
  //         child: Text(
  //           "S",
  //           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //       const SizedBox(width: 12),
  //       Expanded(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: const [
  //             Text(
  //               "Hai, Admin",
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black,
  //               ),
  //             ),
  //             Text(
  //               "Welcome Back!",
  //               style: TextStyle(fontSize: 13, color: Colors.grey),
  //             ),
  //           ],
  //         ),
  //       ),
  //       IconButton(
  //         onPressed: () {},
  //         icon: const Icon(Icons.notifications_none, color: Colors.teal),
  //       ),
  //     ],
  //   );
  // }
}
