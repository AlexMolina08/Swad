import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/providers/coursesProvider.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollPhysics physics = const BouncingScrollPhysics();

    AsyncValue<String> directoryTree = ref.watch(
      directoryTreeProvider("5978"),
    );

    return Scaffold(
      body: SingleChildScrollView(
        physics: physics.applyTo(
          const AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [Text('$directoryTree')],
        ),
      ),
    );
  }
}
