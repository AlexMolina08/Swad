import 'package:flutter/material.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/utilities/constants.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:untitled/utilities/utils.dart' as utils;

/**
 * Widget con la información del usuario
 */
class UserDataWidget extends StatelessWidget {
  final String? userFirstName, userSurname1, userSurname2;
  final String? role;

  UserDataWidget(
      this.userFirstName, this.userSurname1, this.userSurname2, this.role);

  String getRoleText(String rol) {
    switch (rol) {
      case ('1'):
        return "Invitado";
      case ('2'):
        return "Estudiante";
      case ("3"):
        return "Profesor";
      default:
        return "Desconocido";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          Text(
            "Hola $userFirstName.",
            style: TextStyle(fontSize: 25.0),
          ),
          Row(
            children: [
              Text(
                getRoleText(role!),
                style: TextStyle(
                  color: getRoleColor(role!),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color getRoleColor(String role) {
    switch (role) {
      case ('1'):
        return Colors.green;
      case ('2'):
        return kPrimaryColor;
      case ("3"):
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

CircleAvatar buildCircleAvatar(String? imageUrl) {
  return CircleAvatar(
    radius: 37,
    backgroundColor: Color(0xff344955),
    child: CircleAvatar(
        radius: 35,
        backgroundColor: Color(0xbcc7c7c7),
        backgroundImage: NetworkImage(imageUrl!)),
  );
}

/**
 * Devuelve widgets
 */

Widget buildCourseWidget(Course course) {
  final courseColor = GradientColors.yellow;
  return Container(
    constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: courseColor,
      ),
    ),
    child: Text('${course.fullName}'),
  );
}
