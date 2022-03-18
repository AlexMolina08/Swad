import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

/*****************************************************
 *
 * Change notifier y provider respectivo para acceder al indice
 * de la asignatura seleccionada por el user (compartido por todas
 * las ventanas que muestran la lista de asignaturas)
 *
 *****************************************************/
class CourseIndexNotifier extends ChangeNotifier {
  int index;
  CourseIndexNotifier(this.index);
  void update(int newIndex) {
    if (newIndex != index) index = newIndex;
    notifyListeners();
  }
}

final courseIndexProvider = ChangeNotifierProvider<CourseIndexNotifier>(
      (ref) => CourseIndexNotifier(0), // al inicio , el index es 0
);
