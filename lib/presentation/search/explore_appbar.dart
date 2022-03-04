import 'package:flutter/material.dart';

class ExploreAppBar extends StatelessWidget {
  const ExploreAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Container(
        height: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200),
        child: TextField(
          cursorColor: Colors.grey.shade500,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
            ),
            hintText: "Buscar",
          ),

          //style del texto introducido en el textfield
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.5
          ),
        ),
      ),
    );
  }
}
