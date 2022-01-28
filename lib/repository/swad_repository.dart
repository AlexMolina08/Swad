import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/providers/auth_provider.dart';
import 'package:untitled/states/auth_state.dart';
import 'package:xml2json/xml2json.dart';
import 'package:untitled/utilities/utils.dart' as utils;
import 'package:untitled/utilities/enums.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/utilities/constants.dart' as constant;
import 'dart:convert';

/**
 * En esta clase se encuentran todas las llamadas a Swad que se pueden hacer
 * utilizando la API , exceptuando las de Login / Registro
 * */

class SwadRepository {
  final Reader read; // ref.read function

  List<Course> _courseList = [];
  int? numCourses;

  SwadRepository(this.read);


  /**
   *
   * Obtener la lista de asignaturas
   *
   */

  Future<List<Course>> getCourseList() async {
    var ref = read(authNotifierProvider);
    String wsKey = "";
    Xml2Json xml2json = Xml2Json();
    var data;

    if (ref is AuthLoaded) {
      wsKey = ref.auth.wsKey!;
      print('getcourseList: WSKEY obtenida ( $wsKey )');

      try {
        // obtener la peteicion SOAP
        String request = utils.getSoapRequest(
            request: SwadRequest.getCourses, parameters: [wsKey]);

        /*** PETICION SOAP ***/

        http.Response response =
            await http.post(Uri.https(constant.kswad_URL, ""),
                headers: {
                  'content-type': 'text/xmlc',
                  'SOAPAction': 'https://www.swad.ugr.es/api/#getCourses'
                },
                body: utf8.encode(request));

        String xmlResponse = response.body;

        if (response.statusCode == 200) {
          //OK
          xml2json.parse(xmlResponse);
          var jsonResponse = xml2json.toParker();
          data = jsonDecode(jsonResponse);
        } else if (response.statusCode == 500) {
          throw Exception("SWAD REPOSITORY : getCourseList ha fallado");
        }
      } on Exception catch (e) {
        rethrow;
      }
    }

    data = data['SOAP-ENV:Envelope']['SOAP-ENV:Body']['swad:getCoursesOutput'];

    numCourses = int.parse(data['numCourses']);


    data = data['coursesArray']['item'];

    Course c = Course.fromJson(data[0]);

    // Convertir la lista en formato JSON a una List<Course> (lista de asignaturas)
    for(int i = 0 ; i < numCourses! ; ++i) {
      _courseList.add(
        Course.fromJson(data[i])
      );
    }

    // devolvemos la lista
    return _courseList;
  }
}

// PRUEBAS

void main() async {}
