import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/presentation/home/widgets.dart';
import 'package:untitled/providers/auth_providers/auth_provider.dart';
import 'package:untitled/providers/course_providers/coursesProvider.dart';
import 'package:untitled/providers/navigation_providers/page_index_provider.dart';
import 'package:untitled/providers/notifications_provider/get_notifications_provider.dart';
import 'package:untitled/states/auth_state.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("HOME BUILD");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Consumer(
          builder: (context, ref, child) {
            // obtenemos valor del provider con la auntentificacion
            // watch tambien vuelve a hacer build de home widget
            final _authState = ref.watch(authNotifierProvider);

            ///----
            final _notifications = ref.watch(notificationsProvider);
            ///----

            // obtener lista asignaturas
            AsyncValue<List<Course>> courses = ref.watch(courseListProvider);

            //notifier que informa el codigo de la asignatura actual
            //CourseNotifier courseNotifier = ref.watch(courseProvider);
            //--

            // Comprobar si esta identificado el user
            if (_authState is AuthLoaded) {
              // obtener foto
              final imageUrl = _authState.auth.userPhoto;
              return Column(
                children: [
                  // Row con los datos del user
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildCircleAvatar(imageUrl),
                          //SizedBox(height: 10.0,),
                          UserDataWidget(
                            _authState.auth.userFirstname,
                            _authState.auth.userSurname1,
                            _authState.auth.userSurname2,
                            _authState.auth.userRole,
                          ),
                          SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  // Lista de las asignaturas en forma de carousel slider
                  // se llama al async value de courses , y se actua dependiendo
                  // del estado
                  courses.when(
                    data: (courses) {
                      return Flexible(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                              height: 90.0,
                              aspectRatio: 16 / 9,
                              enableInfiniteScroll: true),
                          itemCount: courses.length,
                          itemBuilder: (context, index, realIndex) {
                            final course = courses[index];
                            return Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Hero(
                                tag: 'course',
                                child: buildCourseWidget(
                                  course,
                                  () {
                                    ref.watch(courseProvider).update(course);
                                    ref.watch(pageIndexProvider).update(2);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    error: (err, stack) => Text('Error $err'),
                    loading: () => const CircularProgressIndicator(
                      backgroundColor: Color(0xfffaea05),
                    ),
                  ),
                ],
              );
            } else {
              return UserDataWidget('?', ' ?', '?', '?');
            }
          },
        ),
      ),
    );
  }
}
