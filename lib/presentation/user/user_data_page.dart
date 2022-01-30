import 'package:flutter/material.dart';


class UserDataPage extends StatelessWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('USER DATA' , style: TextStyle(fontSize: 40),)
      ),
    );
  }
}