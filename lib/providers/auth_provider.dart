import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/auth_notifier.dart';
import 'package:untitled/repository/auth_repository.dart';
import 'package:untitled/states/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier,AuthState>( (ref){
  return AuthNotifier();
}
);
