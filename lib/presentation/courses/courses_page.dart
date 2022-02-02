import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_treeview/list_treeview.dart';
import 'package:untitled/models/tree_model.dart';
import 'package:untitled/presentation/courses/widgets.dart';
import 'package:untitled/providers/coursesProvider.dart';

// todo: provider para controlar la carpeta que se está viendo en pantalla
class CoursesPage extends ConsumerWidget {
  CoursesPage({
    Key? key,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScrollPhysics physics = const BouncingScrollPhysics();

    AsyncValue<Dir> directoryTree = ref.watch(
      directoryTreeProvider("5978"),
    );

    return Scaffold(
      body: directoryTree.when(
        data: (tree) {

          // Lista multi-level del directorio mostrada en la UI
          List<Document>? directories = tree.documents;

          return Column(
            children: [
              Text(
                directories.length.toString()
              ),
            ],
          );
        },
        error: (err, stack)
        {
          print(err);
          return Center(
          child: Icon(
            Icons.error_outlined,
            size: 40,
            color: Colors.red,
          ),
          );
        },

        loading: () {
          return CircularProgressIndicator();
        },
      ),
    );
  }

  ///
  /// Renderizar Widget de un directorio
  ///
  

}


class DocumentWidget extends StatelessWidget {
  final Dir dir;

  DocumentWidget(this.dir);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey,
        child: Text('${dir.dirName}'),

      );
  }
}










