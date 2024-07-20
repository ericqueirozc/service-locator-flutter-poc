import 'package:myapp/login/login_credentials.dart';

class LoginRepository {
  Future<bool> login(LoginCredentials loginCredentials) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
