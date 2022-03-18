import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/auth_model.dart';
import 'package:untitled/presentation/home/home.dart';
import 'package:untitled/presentation/login/background.dart';
import 'package:untitled/presentation/login/login_form.dart';
import 'package:untitled/providers/auth_providers/auth_provider.dart';
import 'package:untitled/states/auth_state.dart';
import 'package:untitled/utilities/constants.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // observar estado de auth y hacer rebuild si este cambia
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      //backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          //Background(),
          LoginForm(
            userController: userController,
            passwordController: passwordController,
            // Boton de login
            loginFunction: () async {
              await ref
                  .read(authNotifierProvider.notifier)
                  .login("${userController.text}", "${passwordController.text}")
                  .whenComplete( () {
                  if(ref.read(authNotifierProvider) is AuthLoaded)
                    goToHomePage(context);
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: getAuthWidget(context, authState)),
          )
        ],
      ),
    );
  }
}

void goToHomePage(BuildContext context) {
  Navigator.of(context).pushNamed('/swad');
}

/**
   * Mostrar widget oportuno en base al estado actual de AuthState
   */
Widget getAuthWidget(BuildContext context, AuthState authState) {
  if (authState is AuthLoaded) {
    return Text(authState.auth.userFirstname!);
  }
  if (authState is AuthLoading) return CircularProgressIndicator();

  if (authState is AuthError) return Text("error al iniciar sesion");

  return Text("?");
}
