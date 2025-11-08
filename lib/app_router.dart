import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pbl_jawara_test/pages/auth/login_page.dart';
import 'package:pbl_jawara_test/pages/auth/register_page.dart';
import 'package:pbl_jawara_test/pages/home_dashboard_page.dart';

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
