sealed class LoginState {}

class CredentialUncheckedState extends LoginState {}

class InvalidCredentialsState extends LoginState {}

class SuccessState extends LoginState {}

class ErrorState extends LoginState {}

class LoadingState extends LoginState {}
