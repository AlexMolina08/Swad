/*
*
* Valores constantes conocidos en tiempo de compilación
*
* */



import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';


/****************************************
 * API info
 *****************************************/
const String kswad_URL = "swad.ugr.es";

/* App key para hacer peticiones a Swad */
const String kAppKey = '';

/*****
 * APP INFO
 */

/// Maximo numero de usuarios renderizados
const kUsersPerPage = 40;

/****************************************
 * Styling
 *****************************************/
const Color kBackgroundColor = Color(0xff2A2A2A);
 
const kHomeNameTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold
);

const kSearchAppBarTextStyle = TextStyle(
  color: Color(0xff000000),
  fontWeight: FontWeight.normal,
);

const kPrimaryColor = Color(0xff344955);

// Colores de los items de las asignaturas
const courseItemColors = [
  GradientColors.yellow,
  GradientColors.green,
  GradientColors.amour,
  GradientColors.purple,
  GradientColors.aqua,
];

const kLoadMoreTextStyle = TextStyle(
  color: Color(0xffCCCCCC),
  fontSize: 15.0,
  fontWeight: FontWeight.bold
);

const kNavBarHeight = 60.0;


