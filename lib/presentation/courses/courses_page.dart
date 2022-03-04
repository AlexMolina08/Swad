import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/course_model.dart';
import 'package:untitled/presentation/courses/tree_view.dart';
import 'package:untitled/presentation/home/widgets.dart';
import 'package:untitled/providers/course_index_provider.dart';
import 'package:untitled/providers/coursesProvider.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'widgets.dart';
import 'package:untitled/utilities/constants.dart' as constants;

class CoursesPage extends ConsumerWidget {
  CoursesPage({
    Key? key,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // obtener la asignatura actualmente seleccionada

    // -- Obtener el codigo y el nombre de la asignatura actual
    //String code = currentCourseState!.courseCode ?? '00';
    //String name = currentCourseState.fullName ?? '?';

    /// obtener lista asignaturas
    AsyncValue<List<Course>> courses = ref.watch(courseListProvider);
    int currentCourseIndex = ref.watch(courseIndexProvider).index;

    double screenSize = MediaQuery.of(context).size.height;

    /// obtener el directory tree de la asignatura actual
    /// watch a directoryTreeProvider para hacer rebuild cuando
    /// cambie
    /*AsyncValue<Dir> directoryTree = ref.watch(
      directoryTreeProvider(code),
    );*/

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Container(
          child: courses.when(
            data: (courses) {
              Course selectedCourse = courses[currentCourseIndex];
              return NestedScrollView(
                headerSliverBuilder: (context,value){
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height / 3 ,
                      flexibleSpace: Container(
                        color: Colors.red,
                      ),
                      bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.folder),),
                          Tab(icon: Icon(Icons.folder_shared),),
                          Tab(icon: Icon(Icons.book),),
                        ],
                      ),
                    )
                  ];
                },


                ///
                /// Tabbar que permite seleccionar 3 árboles de la asignatura:
                ///   * Archivos de la asignatura
                ///   * Archivos Compartidos
                ///   * Calificaciones
                ///
                body: TabBarView(
                  children: [
                    ref
                    .watch(directoryTreeProvider(selectedCourse.courseCode!))
                    .when(
                      data: (tree){

                        return tree.documents.isEmpty
                            ? Center(child: Text('Lista vacía'),)
                            : ListView.builder(
                          itemCount: tree.documents.length,
                          itemBuilder: (context, index) {
                            return DirTreeWidget(
                              tree.documents[index],
                            );
                          },
                        );

                      },
                      loading: () {return CircularProgressIndicator();},
                      error: (err,stack) => Icon(Icons.error_outlined)

                    ),

                    Container(),
                    Container()
                  ],
                ),

              );


                /*CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    expandedHeight: screenSize / 5,
                    flexibleSpace: Container(
                      color: Colors.deepOrangeAccent,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index, realIndex) {
                          {
                            final course = courses[index];
                            return Center(child: Text(course.fullName));
                          }
                        },
                        options: CarouselOptions(
                            initialPage: ref.watch(courseIndexProvider).index,
                            onPageChanged: (index, reason) {
                              ref.watch(courseIndexProvider).update(index);
                            },
                            aspectRatio: 16 / 9,
                            enableInfiniteScroll: false),
                      ),
                    ),
                  ),

                  // -- DIRECTORY TREE ---
                  ref
                      .watch(directoryTreeProvider(selectedCourse.courseCode!))
                      .when(
                    data: (tree) {
                      print(tree);
                      return tree.documents.isNotEmpty
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return DirTreeWidget(
                                    tree.documents[index],
                                  );
                                },
                                childCount: tree.documents.length,
                              ),
                            )
                          : SliverEmptyMessage(
                              screenSize: MediaQuery.of(context).size.height);
                    },
                    error: (err, stack) {
                      var screenSize = MediaQuery.of(context).size.height;

                      return SliverErrorIcon(screenSize: screenSize);
                    },
                    loading: () {
                      var screenSize = MediaQuery.of(context).size.height;

                      return LoadingCourses(screenSize: screenSize);
                    },
                  ),

                  ///  espacio añadido al final para no superponer lista con la
                  ///  navbar
                  SliverToBoxAdapter(
                    child: Container(
                      height: constants.kNavBarHeight,
                    ),
                  )
                ],
              );*/
            },
            error: (err, stack) {},
            loading: () {},
          ),
        ),
      ),
    );
  }
}
