import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/presentation/home/widgets.dart';
import 'package:untitled/providers/auth_provider.dart';
import 'package:untitled/providers/coursesProvider.dart';
import 'package:untitled/states/auth_state.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Center(
          child: Consumer(
            builder: (context, ref, child) {
              final _authState = ref.watch(authNotifierProvider);

              // obtener lista asignaturas
              AsyncValue<List<Course>> courses = ref.watch(courseListProvider);

              if (_authState is AuthLoaded) {
                final imageUrl = _authState.auth.userPhoto;
                return Column(
                  children: [
                    Container(
                      // imagen
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: NetworkImage(imageUrl!))),
                    ),
                    // datos
                    UserDataWidget(
                        _authState.auth.userFirstname,
                        _authState.auth.userSurname1,
                        _authState.auth.userSurname2,
                        _authState.auth.userRole),
                    // asignaturas

                    courses.when(
                      data: (courses) {
                        return CarouselSlider(options: CarouselOptions(height: 80.0),
                          items: [Text('aaaaaaa')]);
                      },
                      error: (err, stack) => Text('Error $err'),
                      loading: () => const CircularProgressIndicator(
                        backgroundColor: Colors.yellow,
                      ),
                    ),
                  ],
                );
              } else
                return UserDataWidget("?", "?", "?", "?");
            },
          ),
        ),
      ),
    );
  }

  // TODO HACER UNA LISTA DE WIDGETS



}
