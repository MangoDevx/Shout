class LoginPayload {
  final String username;
  final String password;

  const LoginPayload({required this.username, required this.password});

  Map toJson() => {
    'Username': username,
    'Password': password,
  };
}