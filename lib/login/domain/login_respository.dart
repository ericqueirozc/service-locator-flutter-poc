import 'login_credentials.dart';

abstract class LoginRespository {
  Future<bool> login(LoginCredentials loginCredentials);
}
