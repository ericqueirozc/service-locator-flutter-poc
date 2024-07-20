class LoginCredentials {
  String username;
  String password;

  LoginCredentials({
    required this.username,
    required this.password,
  });

  bool isValid() {
    return username.isNotEmpty && password.isNotEmpty;
  }
}
