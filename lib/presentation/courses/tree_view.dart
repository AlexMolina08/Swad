/**
 *
 * Todos los widgets necesarios para renderizar el Árbol con los docymentos
 * de un directorio en la UI
 *
 */

import 'package:flutter/material.dart';
import 'package:untitled/models/tree_model.dart';

class DirTreeWidget extends StatelessWidget {
  final Document document;
  DirTreeWidget(this.document);

  ///
  /// crear List Tile para cada documento del root
  ///
  Widget _buildTiles(Document root) {
    // comprobar si tiene hijos
    if (root is Dir) {
      if (root.documents.isEmpty) {
        return DirectoryTile(root);
      }
      return ExpansionTile(
        key: PageStorageKey<Dir>(root),
        title: Text(root.dirName),
        children: root.documents.map<Widget>((doc) {
          if (doc is Dir) return _buildTiles(doc);
          if (doc is File) return FileTile(doc);
          return Text('?');
        }).toList(),
      );
    } else{
      return FileTile(File.error());
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

  FileTile(this.file);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.insert_drive_file),
      title: Text(file.name),
    );
  }
}
