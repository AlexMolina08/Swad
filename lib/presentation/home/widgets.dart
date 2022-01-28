import 'package:flutter/material.dart';
import 'package:untitled/utilities/enums.dart';


/**
 * Widget con la información del usuario
 */
class UserDataWidget extends StatelessWidget{

  final String? userFirstName,userSurname1,userSurname2;
  final String? role;

  UserDataWidget(this.userFirstName, this.userSurname1, this.userSurname2 , this.role);



  String getRoleText(String rol){
    switch (rol){
      case('1') : return "Invitado"   ;
      case('2') : return "Estudiante" ;
      case("3") : return "Profesor" ;
      default : return "Desconocido" ;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          "Hola $userFirstName.",
          style: TextStyle(
            fontSize: 25.0
          ),
        ),
        Row(
          children: [Text(getRoleText(role!))],
        )
      ],
    );
  }


}
