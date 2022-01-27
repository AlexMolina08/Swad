import 'package:untitled/models/auth_model.dart';

/**
 * ESTADOS DE LA AUTENTIFICACIÓN EN SWAD
 * **/
abstract class AuthState {
  const AuthState();

}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoaded extends AuthState {
  final Auth auth;
  const AuthLoaded(this.auth);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthLoaded &&
              runtimeType == other.runtimeType &&
              auth == other.auth;

  @override
  int get hashCode => auth.hashCode;
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AuthError &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;
}