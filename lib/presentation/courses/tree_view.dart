/**
 *
 * De Swad se obtiene un documento XML.
 *
 * Aquí estám todos los widgets necesarios para renderizar el Árbol con los docymentos
 * de un directorio en la UI
 *
 */

import 'package:flutter/material.dart';
import 'package:untitled/models/tree_model.dart';
import 'package:untitled/utilities/utils.dart';

class DirTreeWidget extends StatelessWidget {
  final Document document;
  DirTreeWidget(this.document);

  ///
  /// crear List Tile para cada documento del root
  /// esta función se llama recursivamente cuando en el directorio hay otro die
  ///
  Widget _buildTiles(Document root) {
    // comprobar si estamos ante un directorio
    if (root is Dir) {
      if (root.documents.isEmpty) {
        return DirectoryTile(root);
      }
      // si tiene hijos , crear expansiontile
      return ExpansionTile(
        key: PageStorageKey<Dir>(root),
        title: Text(root.dirName),
        children: root.documents.map<Widget>((doc) {
          if (doc is Dir) return _buildTiles(doc);
          if (doc is File)
            return FileTile(
              doc,
              () {
                print(doc.code);
              },
            );
          return Container();
        }).toList(),
      );
    } else {
      if (root is File) {
        return FileTile(
          root,
          () {
            print(root.name);
          },
        );
      }else{
        return SizedBox(height: 20.0,);
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(document);
  }
}

class DirectoryTile extends StatelessWidget {
  final Dir dir;

  DirectoryTile(this.dir);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.folder),
      title: Text('${dir.dirName}'),
    );
  }
}

class FileTile extends StatelessWidget {
  final File file;
  final void Function()? onTap;
  FileTile(this.file, this.onTap);

  @override
  Widget build(BuildContext context) {
    String formatedSize = formatBytes(int.parse(file.size), 2);

    return ListTile(
      onTap: onTap,
      leading: Icon(Icons.insert_drive_file),
      title: Text(file.name),
      subtitle: Text(formatedSize),
    );
  }
}
