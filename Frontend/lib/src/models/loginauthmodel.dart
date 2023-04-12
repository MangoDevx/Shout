class LoginAuthModel {
  final String username;
  final String password;

  const LoginAuthModel({required this.username, required this.password});

  Map toJson() => {
    'Username': username,
    'Password': password,
  };
}