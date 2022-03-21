import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/models/find_user_request.dart';
import 'package:untitled/models/tree_model.dart';
import 'package:untitled/providers/auth_providers/auth_provider.dart';
import 'package:untitled/states/auth_state.dart';
import 'package:untitled/states/search_state.dart';
import 'package:xml2json/xml2json.dart';
import 'package:untitled/utilities/utils.dart' as utils;
import 'package:untitled/utilities/enums.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/utilities/constants.dart' as constant;
import 'dart:convert';
import 'package:xml/xml.dart';



///En SwadRepository se encuentran todas las llamadas a Swad que se pueden hacer
///utilizando la API , exceptuando las de Login / Registro

class SwadRepository {
  final Reader read; // ref.read function

  List<Course> _courseList = [];
  int? numCourses;
  String? currentCourseCode;

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

    Course c = Course.fromJson(data);

    // Convertir la lista en formato JSON a una List<Course> (lista de asignaturas)
    if (numCourses! > 1) {
      for (int i = 0; i < numCourses!; ++i) {
        _courseList.add(Course.fromJson(data[i]));
      }
    } else
      _courseList.add(Course.fromJson(data));

    /// establecer por defecto primer curso
    currentCourseCode = _courseList.first.courseCode;

    /// devolver la lista
    return _courseList;
  }

  Future<Dir> getCourseDirectories(String courseCode) async {
    // obtener wskey
    var ref = read(authNotifierProvider);
    String wsKey = "";

    Dir? dirTree;

    // Comprobar si el usuario está logeado
    if (ref is AuthLoaded) {
      wsKey = ref.auth.wsKey!;
      try {
        // obtener la peticion SOAP
        String request = utils.getSoapRequest(
            request: SwadRequest.getDirectoryTree,
            parameters: [wsKey, courseCode]);

        /*** PETICION SOAP ***/
        http.Response response =
            await http.post(Uri.https(constant.kswad_URL, ""),
                headers: {
                  'content-type': 'text/xmlc',
                  'SOAPAction': 'https://www.swad.ugr.es/api/#getDirectoryTree'
                },
                body: utf8.encode(request));

        String xmlResponse = response.body;

        if (response.statusCode == 200) {
          //OK

          final document = XmlDocument.parse(xmlResponse);

          /// extraer el directoryTree
          final textual = document
              .getElement('SOAP-ENV:Envelope')
              ?.getElement('SOAP-ENV:Body')
              ?.getElement('swad:getDirectoryTreeOutput')
              ?.getElement('tree');

          /// pasar el xmlElement con el directoryTree a string
          var docsTextual = textual?.firstChild.toString();

          /// establecer formato adecuado
          docsTextual = docsTextual?.replaceAll('&lt;', '<');

          /// convertir el string a un xml
          final directoryTreeDocument = XmlDocument.parse(docsTextual!);

          /// obtener modelo Dir
          dirTree = Dir.fromElement(
            directoryTreeDocument.getElement('tree')!,
          );
        } else if (response.statusCode == 500) {
          throw Exception("SWAD REPOSITORY : getDirectoryTree ha fallado");
        }
      } on Exception catch (e) {
        rethrow;
      }
    }

    return dirTree ?? Dir.root();
  }

  ///
  /// Buscar un usuario en la plataforma
  ///

  Future<SearchState> findUsers(SearchRequest request) async {
    var ref = read(authNotifierProvider);
    String wsKey = "";
    Xml2Json xml2json = Xml2Json();
    var data;

    if (ref is AuthLoaded) {
      wsKey = ref.auth.wsKey!;

      try {
        // obtener la peticion SOAP
        String soapRequest = utils.getSoapRequest(
            request: SwadRequest.findUsers,
            parameters: [wsKey, request.courseCode, request.filter, request.userRole]);

        /*** PETICION SOAP ***/

        http.Response response =
            await http.post(Uri.https(constant.kswad_URL, ""),
                headers: {
                  'content-type': 'text/xmlc',
                  'SOAPAction': 'https://www.swad.ugr.es/api/#findusers'
                },
                body: utf8.encode(soapRequest));

        String xmlResponse = response.body;

        if (response.statusCode == 200) {
          /// Ejecutar en segundo plano la conversión del XML
          data = await compute(parseData,xmlResponse);

        } else if (response.statusCode == 500) {
          throw Exception("SWAD REPOSITORY : Findusers ha fallado");
        }
      } on Exception catch (e) {
        rethrow;
      }

      // obtener numUsers del json. Si es null , devolver 0
      String numUsers = data['numUsers'] ?? '0';
      // obtener el usersArray
      var usersArray = (int.parse(numUsers) > 0)
          ? data['usersArray']['item']
          : data;

      return SearchLoaded(
              numUsers: int.parse(numUsers),
              userListResponse: usersArray
            );
    } else {
      return SearchError("Inicia sesión");
    }
  }

  Future<String> getNotifications() async{
    var ref = read(authNotifierProvider);
    var xmlResponse = '';
    String wsKey = "";
    Xml2Json xml2json = Xml2Json();
    var data;

    if (ref is AuthLoaded) {
      wsKey = ref.auth.wsKey!;

      try {
        // obtener la peteicion SOAP
        String request = utils.getSoapRequest(
            request: SwadRequest.getNotifications, parameters: [wsKey]);

        /*** PETICION SOAP ***/

        http.Response response =
            await http.post(Uri.https(constant.kswad_URL, ""),
            headers: {
              'content-type': 'text/xmlc',
              'SOAPAction': 'https://www.swad.ugr.es/api/#getNotifications'
            },
            body: utf8.encode(request));

         xmlResponse = response.body;

        /*if (response.statusCode == 200) {
          //OK
          xml2json.parse(xmlResponse);
          var jsonResponse = xml2json.toParker();
          data = jsonDecode(jsonResponse);
        } else if (response.statusCode == 500) {
          throw Exception("SWAD REPOSITORY : getCourseList ha fallado");
        }*/
      } on Exception catch (e) {
        rethrow;
      }
      print(xmlResponse);
      return xmlResponse;
    }

    /*data = data['SOAP-ENV:Envelope']['SOAP-ENV:Body']['swad:getCoursesOutput'];

    numCourses = int.parse(data['numCourses']);

    data = data['coursesArray']['item'];

    Course c = Course.fromJson(data);

    // Convertir la lista en formato JSON a una List<Course> (lista de asignaturas)
    if (numCourses! > 1) {
      for (int i = 0; i < numCourses!; ++i) {
        _courseList.add(Course.fromJson(data[i]));
      }
    } else
      _courseList.add(Course.fromJson(data));

    /// establecer por defecto primer curso
    currentCourseCode = _courseList.first.courseCode;*/

    /// devolver la lista
    return xmlResponse;
  }

}


dynamic parseData(xmlResponse){

  var data;
  Xml2Json xml2json = Xml2Json();
  //OK
  xml2json.parse(xmlResponse);
  // obtener el String con el JSON de los alumnos encontrados
  var jsonResponse = xml2json.toParker();
  data = jsonDecode(jsonResponse);
  // campo con lista de los alumnos filtrados
  data =
  data['SOAP-ENV:Envelope']['SOAP-ENV:Body']['swad:getUsersOutput'];

  return data;
}

// PRUEBAS

void main() async {}
