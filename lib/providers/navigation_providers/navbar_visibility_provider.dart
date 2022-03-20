import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/**
 *
 * Provider para la visibilidad de la Navigation Bar
 *
 */


final navBarVisibilityProvider = ChangeNotifierProvider<NavBarVisibility>(
        (ref) => NavBarVisibility(true) /// Al inicio siempre mostrar NavBar
);

/// Change notifier para controlar el estado actual de la visibilidad

class NavBarVisibility extends ChangeNotifier {
  bool visibility;
  NavBarVisibility(this.visibility);


  void show() {
    visibility = true;
    notifyListeners();
  }
  void hide() {
    visibility = false;
    notifyListeners();
  }

}






