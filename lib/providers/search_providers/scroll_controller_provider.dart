


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollControllerNotifier extends ChangeNotifier{

}

final myNotifierProvider = ChangeNotifierProvider.autoDispose<ScrollControllerNotifier>((ref) {
  return ScrollControllerNotifier();
});
