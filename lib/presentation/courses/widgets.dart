import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:untitled/models/tree_model.dart';

///
/// Widget de una carpeta de un curso
/// muestra nombre y responde al pulsar
///
class DirectoryWidget extends StatelessWidget {
  final Dir directory;

  final void Function() onTap;

  DirectoryWidget({required this.directory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black , width: .5),
          gradient: LinearGradient(
            colors: GradientColors.white
          )
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 12,
        child: Text(directory.dirName),
      ),
    );
  }
}
