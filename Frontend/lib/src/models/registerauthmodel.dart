class RegisterAuthModel {
  final String username;
  final String password;
  final String phoneNumber;

  const LoginAuthModel({required this.username, required this.password, required this.phoneNumber});

  Map toJson() => {
    'Username': username,
    'Password': password,
    'PhoneNumber': phoneNumber,
  };
}