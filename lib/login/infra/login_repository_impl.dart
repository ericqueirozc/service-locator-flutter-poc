import 'package:myapp/login/domain/login_credentials.dart';
import 'package:myapp/login/domain/login_respository.dart';

class LoginRepositoryImpl implements LoginRespository {
  @override
  Future<bool> login(LoginCredentials loginCredentials) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
