import 'package:pbl_jawara_test/models/user_model.dart';

List<UserModel> dummyUsers = [
  UserModel(
    id: 1,
    email: 'user1@example.com',
    password: '123456',
    role: UserRole.adminSistem,
    name: 'User 1',
    phone: '081234567890',
    createdAt: DateTime.now(),
    // imageProfile: 'https://example.com/user1.jpg',
  ),
  UserModel(
    id: 2,
    email: 'user2@example.com',
    password: '123456',
    role: UserRole.ketuaRT,
    name: 'User 2',
    phone: '081234567891',
    createdAt: DateTime.now(),
    // imageProfile: 'https://example.com/user2.jpg',
  ),
  UserModel(
    id: 3,
    email: 'user3@example.com',
    password: '123456',
    role: UserRole.ketuaRW,
    name: 'User 3',
    phone: '081234567892',
    createdAt: DateTime.now(),
    // imageProfile: 'https://example.com/user3.jpg',
  ),
];
