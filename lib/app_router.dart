import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl_jawara_test/pages/auth/login_page.dart';
import 'package:pbl_jawara_test/pages/auth/register_page.dart';
import 'package:pbl_jawara_test/pages/home_dashboard_page.dart';
import 'package:pbl_jawara_test/pages/user_management/user_management_page.dart';
import 'package:pbl_jawara_test/pages/user_management/add_user_page.dart';
import 'package:pbl_jawara_test/pages/user_management/edit_user_page.dart';
import 'package:pbl_jawara_test/pages/user_management/user_detail_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: <GoRoute>[
    // ====== Autentikasi ======
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    // ====== Home Dashboard ======
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeDashboardPage(),
    ),
    // ====== Manajemen Pengguna ======
    GoRoute(
      path: '/user-management',
      name: 'user-management',
      builder: (context, state) => const UserManagementPage(),
    ),
    GoRoute(
      path: '/user-management/add',
      name: 'user-management-add',
      builder: (context, state) => const AddUserPage(),
    ),
    GoRoute(
      path: '/user-management/edit/:id',
      name: 'user-management-edit',
      builder: (context, state) {
        final userId = state.pathParameters['id']!;
        return EditUserPage(userId: userId);
      },
    ),
    GoRoute(
      path: '/user-management/detail/:id',
      name: 'user-management-detail',
      builder: (context, state) {
        final userId = state.pathParameters['id']!;
        return UserDetailPage(userId: userId);
      },
    ),
    // ====== Popup Menu ======
    GoRoute(
      path: '/menu-popup',
      name: 'menu-popup',
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(),
      ),
    ),
  ],
);
