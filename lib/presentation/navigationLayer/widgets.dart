import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class SwadNavigationBar extends StatefulWidget {
  const SwadNavigationBar({Key? key , required this.onTap}) : super(key: key);

  final void Function(int)? onTap; // funcion  que recibe como parametro el index
  // del icon seleccionado

  @override
  _SwadNavigationBarState createState() => _SwadNavigationBarState();
}

class _SwadNavigationBarState extends State<SwadNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: Duration(milliseconds: 300),
        color: Color(0xffEEA305),
        items: navigationBarIcons(),
        height: 60.0,
        onTap: widget.onTap
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