import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/page_index_provider.dart';
import 'package:untitled/utilities/constants.dart' as constants;

class SwadNavBar extends ConsumerWidget {
  const SwadNavBar({Key? key, required this.onTap}) : super(key: key);

  final void Function(int)?
      onTap; // funcion  que recibe como parametro el index
  // del icon seleccionado

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DotNavigationBar(
      enableFloatingNavBar: true,
      backgroundColor: const Color(0xfffafafa),
      dotIndicatorColor: Colors.transparent,
      onTap: onTap,
      // obtener el index actual
      currentIndex: ref.watch(pageIndexProvider).index,
      items: navigationBarIcons(),
    );
  }
}
/// Return a list with navBar icons
List<DotNavigationBarItem> navigationBarIcons() {
  const Color iconColor = Colors.white;
  return <DotNavigationBarItem>[
    DotNavigationBarItem(
      unselectedColor: Colors.grey,
      icon: const Icon(
        Icons.home,
      ),
    ),
    DotNavigationBarItem(
      unselectedColor: Colors.grey,
      icon: const Icon(Icons.search),
      selectedColor: Colors.blue
    ),
    DotNavigationBarItem(
        unselectedColor: Colors.grey,
        icon: const Icon(Icons.book),
      selectedColor: Colors.amber
    ),
    DotNavigationBarItem(
      unselectedColor: Colors.grey,
      icon: const Icon(Icons.person),
    )
  ];
}
