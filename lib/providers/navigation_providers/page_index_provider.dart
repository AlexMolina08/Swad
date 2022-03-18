import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/*****************************************************
 *
 * Change notifier y provider respectivo para manejar el estado
 * de la pantalla
 *
 *****************************************************/
class ScreenIndexNotifier extends ChangeNotifier {
  int index;
  ScreenIndexNotifier(this.index);
  void update(int newIndex) {
    if (newIndex != index) index = newIndex;
    notifyListeners();
  }
}

final pageIndexProvider = ChangeNotifierProvider<ScreenIndexNotifier>(
  (ref) => ScreenIndexNotifier(0), // al inicio , el index es 0
);
