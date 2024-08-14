class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String roles;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.roles = 'USER',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone ?? '',
      'roles': roles,
    };
  }
}
