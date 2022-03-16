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
import 'widgets.dart';
import 'package:untitled/providers/page_index_provider.dart';

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');




class NavigationLayer extends StatefulWidget {
  const NavigationLayer({Key? key}) : super(key: key);

  @override
  State<NavigationLayer> createState() => _NavigationLayerState();
}

class _NavigationLayerState extends State<NavigationLayer> {
  int index = 0;


  final screens = [
    HomePage(),
    SearchPage(),
    CoursesPage(),
    UserDataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // scaffold wrapped with willpopscope in order to prevent go to previous page from the
    // system back button UI
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          bottomNavigationBar: Consumer(
            builder: (context, ref, child) {
              return SwadNavBar(
                key: globalKey,
                onTap: (newIndex) {
                  ref.watch(pageIndexProvider).update(newIndex);
                },
              );
            },
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
