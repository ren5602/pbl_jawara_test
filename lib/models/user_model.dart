class UserModel {
  final int id;
  final String name;
  final String password;
  final String email;
  final UserRole role;
  final String phone;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.role,
    required this.phone,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
      ),
      phone: json['phone'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'role': role.toString().split('.').last,
      'phone': phone,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum UserRole { adminSistem, ketuaRT, ketuaRW, bendahara, sekretaris, warga }

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.adminSistem:
        return 'Admin Sistem';
      case UserRole.ketuaRT:
        return 'Ketua RT';
      case UserRole.ketuaRW:
        return 'Ketua RW';
      case UserRole.bendahara:
        return 'Bendahara';
      case UserRole.sekretaris:
        return 'Sekretaris';
      case UserRole.warga:
        return 'Warga';
    }
  }
}
