import 'package:flutter/material.dart';
import 'package:myapp/login/login_credentials.dart';
import 'package:myapp/login/login_repository.dart';

import 'login_state.dart';

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1395942664.
class LoginStore extends ValueNotifier<LoginState> {
  LoginStore() : super(CredentialUncheckedState());

  void setState(LoginState state) {
    value = state;
  }

  Future<void> login(LoginCredentials loginCredentials) async {
    if (!loginCredentials.isValid()) {
      setState(InvalidCredentialsState());
      return;
    }
    setState(LoadingState());
    final hasLogedSuccefully = await LoginRepository().login(loginCredentials);
    if (!hasLogedSuccefully) {
      setState(ErrorState());
      return;
    }
    setState(SuccessState());
  }
}
