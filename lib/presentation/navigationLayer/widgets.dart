import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/page_index_provider.dart';
import 'package:untitled/utilities/constants.dart' as constants;

import 'navigation_layer.dart';

class SwadNavigationBar extends ConsumerWidget {
  const SwadNavigationBar({Key? key , required this.onTap}) : super(key: key);

  final void Function(int)? onTap; // funcion  que recibe como parametro el index
  // del icon seleccionado

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      animationDuration: Duration(milliseconds: 300),
      color: Color(0xffEEA305),
      items: navigationBarIcons(),
      height: constants.kNavBarHeight,
      onTap: onTap,
      // obtener el index actual
      index: ref.watch(pageIndexProvider).index,
    );
  }
}

List<Widget> navigationBarIcons() {
  const Color iconColor = Colors.white;
  return const <Widget>[
    Icon(
      Icons.home,
      size: 30,
      color: iconColor,
    ),
    Icon(Icons.search, color: iconColor),
    Icon(Icons.book, color: iconColor),
    Icon(Icons.person, color: iconColor)
  ];
}