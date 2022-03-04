import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:untitled/models/tree_model.dart';

class SliverErrorIcon extends StatelessWidget {
  const SliverErrorIcon({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: screenSize / 4,
          ),
          const Icon(
            Icons.error_outlined,
            size: 40,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class SliverEmptyMessage extends StatelessWidget {
  const SliverEmptyMessage({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: screenSize / 4,
          ),
          const Text(
            'Nada por aquí'
          ),
        ],
      ),
    );
  }
}

class LoadingCourses extends StatelessWidget {
  const LoadingCourses({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  final double screenSize;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: screenSize / 4),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

/*
* Card con el nombre del un curso
* */
class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: .2),
          borderRadius: BorderRadius.circular(15.0)
      ),
      borderOnForeground: true,
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
