import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/repository/auth_repository.dart';
import 'package:untitled/states/auth_state.dart';

/**
 * AuthNotifier es la clase responsable de llamar a authRepository para obtener
 * los datos de autentificación y actualizar el estado para que se vea reflejado
 * en la aplicación
 */
class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository = AuthRepository(); // inicializar auth repo

  AuthNotifier()
      : super(
          AuthInitial(),
        );



  Future<void> login(String user , String password) async{

    try {
      state = AuthLoading(); // El estado pasa a ser loading
      final auth = await authRepository.loginByUserPasswordKey(user, password);
      // al finalizar el login , el estado para a loaded
      state = AuthLoaded(auth);
    } on Exception catch (e) {
      // en caso de error el estado pasa a error
      state = AuthError("Usuario o contraseña incorrectos");

    }

  }

}
