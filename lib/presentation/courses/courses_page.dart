import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/tree_model.dart';
import 'package:untitled/presentation/courses/tree_view.dart';
import 'package:untitled/providers/coursesProvider.dart';
import 'package:untitled/utilities/constants.dart' as constants;

class CoursesPage extends ConsumerWidget {
  CoursesPage({
    Key? key,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentCourseState = ref.watch(courseProvider).course;

    // -- Obtener el codigo de la asignatura actual
    String code = currentCourseState!.courseCode ?? '00';
    String name = currentCourseState.fullName ?? '?';
    // --

    // obtener el directory tree de la asignatura actual
    // watch a directoryTreeProvider
    AsyncValue<Dir> directoryTree = ref.watch(
      directoryTreeProvider(code),
    );

    return Scaffold(
      body: Container(
        child: _buildListView(
          name,
          context,
          ref.watch(
            directoryTreeProvider(code),
          ),
        ),
      ),
    );
  }

  CustomScrollView _buildListView(
      String name, BuildContext context, AsyncValue<Dir> tree) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        // appbar con nombre de la asingatura
        SliverAppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
              title: Text(name),
              background: Container(
                color: Colors.orange,
              )),
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.30,
        ),

        tree.when(
          data: (tree) {
            print(tree);
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return DirTreeWidget(
                    tree.documents[index],
                  );
                },
                childCount: tree.documents.length,
              ),
            );
          },
          error: (err, stack) {
            var screenSize = MediaQuery.of(context).size.height;

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
          },
          loading: () {
            var screenSize = MediaQuery.of(context).size.height;

            return SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: screenSize / 4),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),

        SliverPadding(
          padding: EdgeInsets.only(bottom: constants.kNavBarHeight),
        )
      ],
    );
  }
}
