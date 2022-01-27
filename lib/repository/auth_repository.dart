import 'package:untitled/models/auth_model.dart';
import 'package:untitled/utilities/constants.dart' as constants;
import 'package:untitled/utilities/enums.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/utilities/utils.dart' as utils;
import 'dart:convert';



class InvalidAuthException implements Exception {
  final String message;
  InvalidAuthException({required this.message});
}

/**
 *
 * Donde se envian los datos del login a la api para obtener un Auth (modelo con
 * los datos del user)
 *
 */

class AuthRepository {



  AuthRepository();

  Future<Auth> loginByUserPasswordKey(String user, String password) async {

    var data;

    // inicializo objeto Xml2Json (ayuda para conversion a json)
    Xml2Json xml2json = Xml2Json();
    // obtener contraseña encriptada
    String encriptedPass = utils.encryptPassword(password);
    // obtener la peteicion SOAP
    String request = utils.getSoapRequest(
        request: SwadRequest.LoginByUserPasswordKey, parameters: [user,encriptedPass,constants.kAppKey]);

    // ******** peticion POST a SWAD ********

    try {
      http.Response response = await http.post(
        Uri.https(constants.kswad_URL, ""),
        headers: {
          'content-type' : 'text/xmlc',
          'SOAPAction': 'https://www.swad.ugr.es/api/#loginByUserPasswordKey'
        },
        body: utf8.encode(request)
      );
      
      String xmlResponse = response.body;
      
      if (response.statusCode == 200) { //OK
        xml2json.parse(xmlResponse);
        var jsonResponse = xml2json.toParker();
        data = jsonDecode(jsonResponse);
      }else if(response.statusCode == 500) {
        throw InvalidAuthException(message: "Usuario o contraseña no válidos");
      }


    } on InvalidAuthException catch (e) {
      throw e;
    }

    return Auth.fromJson(data['SOAP-ENV:Envelope']['SOAP-ENV:Body']
    ['swad:loginByUserPasswordKeyOutput']);




  }
}

void main() async{

  var result = await AuthRepository().loginByUserPasswordKey("amcr", "84Uyiqun");

  print(result.toString());

}
