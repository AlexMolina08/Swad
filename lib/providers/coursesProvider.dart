import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/models/tree_model.dart';
import 'package:untitled/presentation/courses/courses_page.dart';
import 'package:untitled/providers/auth_provider.dart';
import 'package:untitled/repository/swad_repository.dart';
import 'package:flutter/foundation.dart';

// Provider del Swad Repository

final courseListProvider = FutureProvider<List<Course>>(
  (ref) async {
    final SwadRepository repo = SwadRepository(ref.read);

    final content = await repo.getCourseList();

    return content;
  },
);



final directoryTreeProvider = FutureProvider.family.autoDispose<Dir,String> (

    (ref , courseCode) async {
      final SwadRepository repo = SwadRepository(ref.read);
      final Dir content = await repo.getCourseDirectories(courseCode);
      return content;
    });

/*****************************************************
 *
 * Change notifier y provider respectivo de la asignatura
 * seleccionada por el usuario en ese momento
 *
 *****************************************************/
class CourseNotifier extends ChangeNotifier {
  /*
  TODO: course nunca debe ser null , si el user no ha seleccionado course ,
                     establecer la primera de la lista de courses
  */

  Course? course;
  CourseNotifier();

  // actualizar codigo asignatura actual
  void update(Course newCourse) {
    course = newCourse;
    print("actualizado");
    notifyListeners();
  }

}



final courseProvider = ChangeNotifierProvider.autoDispose<CourseNotifier>(
        (ref) {
      return CourseNotifier();
    }
);
