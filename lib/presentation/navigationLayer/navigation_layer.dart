/**
 * Layer con la appbar y la botton nav bar presentes en todas las pantallas
 * principales de swad
 * */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/presentation/courses/courses_page.dart';
import 'package:untitled/presentation/home/home.dart';
import 'package:untitled/presentation/search/search_page.dart';
import 'package:untitled/presentation/user/user_data_page.dart';
import 'package:untitled/providers/navigation_providers/navbar_visibility_provider.dart';
import 'widgets.dart';
import 'package:untitled/providers/navigation_providers/page_index_provider.dart';

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

class NavigationLayer extends ConsumerStatefulWidget {
  const NavigationLayer({Key? key}) : super(key: key);

  @override
  NavigationLayerState createState() => NavigationLayerState();
}

class NavigationLayerState extends ConsumerState<NavigationLayer> {
  int index = 0;

  final screens = [
    HomePage(),
    SearchPage(),
    CoursesPage(),
    UserDataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    /// comprobar la visibilidad de la appBar
    final bool showNavBar = ref.watch(navBarVisibilityProvider).visibility;

    /// scaffold wrapped with willpopscope in order to prevent go to previous page from the
    /// system back button UI
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,

          /// BOTTOM NAVIGATION BAR ANIMADA
          bottomNavigationBar: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            /// ocultar la appbar significa que su altura es 0
            height: showNavBar ? MediaQuery.of(context).size.width / 4 : 0.0,
            child: Wrap(
              children: [
                Container(

                  child: SwadNavBar(
                    key: globalKey,
                    onTap: (newIndex) {
                      ref.read(pageIndexProvider).update(newIndex);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Consumer(
            builder: (context, ref, child) {
              int currentIndex = ref.watch(pageIndexProvider).index;
              return screens[currentIndex];
            },
          ),
        ),
      ),
    );
  }
}
