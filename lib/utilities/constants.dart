/*
*
* Valores constantes conocidos en tiempo de compilación
*
* */



import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

const String kswad_URL = "swad.ugr.es";

/* App key para hacer peticiones a Swad */
const String kAppKey = 'alexflutter123';

const Color kBackgroundColor = Color(0xff2A2A2A);

const kHomeNameTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold
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
