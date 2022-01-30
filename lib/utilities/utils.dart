import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:untitled/utilities/utils.dart' as utils;
import 'package:untitled/utilities/constants.dart' as constants;

import 'enums.dart';



/*
*
* Encripta la contraseña del usuario con el algoritmo SHA512
*
*
* */

String encryptPassword (String password){

  String result="";

  try {
    // bytes de la password
    List<int> bytes = utf8.encode(password);
    // encriptacion a sha-512
    Digest sha512result = sha512.convert(bytes);
    // conversion del resultado a base64 url safe
    String str = base64.encode(sha512result.bytes);
    String result = str.replaceAll('+', '-').replaceAll('/', '_').replaceAll(
        '=', ' ').replaceAll("\\s+", "");

    return result;

  } catch (e){
    print("ERROR EN LA CONVERSIÓN: ");
    throw e;
  }
}


/**
 *
 * Obtener String XML de la peticion a SWAD
 *
 */

String getSoapRequest({required SwadRequest request , required List<String> parameters}){

  String soapRequest = "";

  switch(request){
    case SwadRequest.loginByUserPasswordKey :
      {

        String user = parameters.first;
        String password = parameters[1];

        soapRequest = '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:swad">
       <soapenv:Header/>
       <soapenv:Body>
          <urn:loginByUserPasswordKey>
             <!--Optional:-->
             <userID>$user</userID>
             <!--Optional:-->
             <userPassword>$password</userPassword>
             <!--Optional:-->
             <appKey>${constants.kAppKey}</appKey>
          </urn:loginByUserPasswordKey>
       </soapenv:Body>
    </soapenv:Envelope>''' ;
      }
      break;

    case SwadRequest.getCourses : {

      String wsKey = parameters.first;



      soapRequest = '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:swad">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getCourses>
         <!--Optional:-->
         <wsKey>$wsKey</wsKey>
      </urn:getCourses>
   </soapenv:Body>
</soapenv:Envelope>''';
    }
    break;

    // Archivos
    case SwadRequest.getDirectoryTree :
    {
      String wsKey = parameters.first;
      String courseCode = parameters[1];

      soapRequest = '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:swad">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:getDirectoryTree>
         <!--Optional:-->
         <wsKey>$wsKey</wsKey>
         <courseCode>$courseCode</courseCode>
         <groupCode>0</groupCode>
         <treeCode>1</treeCode>
      </urn:getDirectoryTree>
   </soapenv:Body>
</soapenv:Envelope>''';

    }break;
  }

  return soapRequest;
}



// PRUEBAS

main() async {

  String password = utils.encryptPassword("84Uyiqun");

  String soapRequest = '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:swad">
   <soapenv:Header/>
   <soapenv:Body>
      <urn:loginByUserPasswordKey>
         <!--Optional:-->
         <userID>@amcr</userID>
         <!--Optional:-->
         <userPassword>$password</userPassword>
         <!--Optional:-->
         <appKey>${constants.kAppKey}</appKey>
      </urn:loginByUserPasswordKey>
   </soapenv:Body>
</soapenv:Envelope>''' ;
  
  
  http.Response response = await http.post(
    Uri.http(constants.kswad_URL, ""),
    headers: {
      'content-type': 'text/xmlc',
      'SOAPAction': 'https://swad.ugr.es/api/#loginByUserPasswordKey'
    },
    body: utf8.encode(soapRequest),
  );

  print(response.body);
  
  


}


GradientColors getRandomColor(List<GradientColors> l ) {
  var rng = Random();
  int randomIndex = rng.nextInt(l.length-1);
  return l[randomIndex];
}





//NfYmVS0J1k953XMpM43k-jd0yiiLQhnImnEMm9CKAl7Zu2HFgaT-e4bzHG4COrG7jShSQYCB7ExvnjzS28B3fw