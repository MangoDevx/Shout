class UserModel {
  static final UserModel _instance = UserModel._internal();
  String username = '';

  factory UserModel() {
    return _instance;
  }

  UserModel._internal() {
    // initialization logic
  }

  void setUsername(String username) {
    this.username = username;
  }

  String getUsername() {
    return username;
  }
}