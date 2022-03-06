import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/auth_notifier.dart';
import 'package:untitled/states/auth_state.dart';

// Provider de los datos del usuario al iniciar sesión
final authNotifierProvider = StateNotifierProvider<AuthNotifier,AuthState>( (ref){
  return AuthNotifier();
}
);

// Provider que obtiene las asignaturas del usuario de la sesión actual

/*final coursesProvider = FutureProvider.autoDispose<String>( (ref){

  }
);*/