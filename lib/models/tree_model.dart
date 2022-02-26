/**
 *
 * Clases para representar los directorios y archivos obtenidos de Swad
 *
 */
import 'package:xml/xml.dart';
import 'package:list_treeview/list_treeview.dart';


abstract class Document {

}


///******************************************************************************
///                Modelo de un archivo de Swad
///******************************************************************************
///
class File extends Document{
  String? _name;
  String? _code;
  String? _size;
  String? _time;
  String? _license;
  String? _publisher;
  String? _photo;

  String? url;


  File(this._name, this._code, this._size, this._time, this._license,
      this._publisher, this._photo)
      : super();

  File.error(){
    _name = "?";
  }

  ///   crear una instancia de un Archivo a partir de un XML element

  File.fromElement(XmlElement e) {
    _name = e.getAttribute('name') ?? 'unknown';
    _code = e.getElement('code').toString();
    _size = e.getElement('size').toString();
    _time = e.getElement('time').toString();
    _license = e.getElement('license').toString();
    _publisher = e.getElement('publisher').toString();
    _photo = e.getElement('photo').toString();

    _removeTags();
  }

  ///
  /// eliminar tags XML
  ///
  void _removeTags() {
    code = code
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('code', '')
        .replaceAll('/', '');

    name = name
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('name', '')
        .replaceAll('/', '');

    size = size
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('size', '')
        .replaceAll('/', '');
    time = time
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('time', '')
        .replaceAll('/', '');
    license = license
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('license', '')
        .replaceAll('/', '');
    publisher = publisher
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('publisher', '')
        .replaceAll('/', '');
    photo = photo
        .replaceAll('<', '')
        .replaceAll('>', '')
        .replaceAll('photo', '')
        .replaceAll('/', '');
  }

  @override
  String toString() {
    return 'File{_name: $_name, _code: $_code, _size: $_size, _time: $_time, _license: $_license, _publisher: $_publisher, _photo: $_photo}';
  }

  String get photo => _photo!;

  set photo(String value) {
    _photo = value;
  }

  String get publisher => _publisher!;

  set publisher(String value) {
    _publisher = value;
  }

  String get license => _license!;

  set license(String value) {
    _license = value;
  }

  String get time => _time!;

  set time(String value) {
    _time = value;
  }

  String get size => _size!;

  set size(String value) {
    _size = value;
  }

  String get code => _code!;

  set code(String value) {
    _code = value;
  }

  String get name => _name!;

  set name(String value) {
    _name = value;
  }
}

///******************************************************************************
///                Modelo de un directorio de Swad
/// Un directorio consta de una lista de archivos , una lista de directorios y
/// su nombre
///******************************************************************************
///
class Dir extends Document {

  // Lista de documentos del directorio , ya sean archivos o directorios
  List<Document> documents = [];

  String dirName;

  Dir({required this.documents, required this.dirName});

  Dir.root({this.dirName = 'root'});

  int getNumFiles() {
    return documents.length;
  }

  ///
  /// Constructor recursivo , crea un directorio e inicializa la lista de directorios
  /// (llamando a esta misma funcion) y los archivos
  ///
  factory Dir.fromElement(XmlElement xmlTree) {

    /// Obtener lista de directorios
    List<Dir> directories  = xmlTree
        .findElements('dir')
        .map<Dir>((e) {
          return Dir.fromElement(e);
    }).toList();

    /// obtener lista de archivos
    List<File> files = xmlTree.findElements('file').map<File>((e) {
      return File.fromElement(e);
    }).toList();


    /// eliminar caracteres que no se necesitan
    String name = xmlTree.attributes
        .toString()
        .replaceAll('[name="', '')
        .replaceAll('"]', '');

    /// Lista de documentos (tanto files como dirs)
    List<Document> docs = [...directories , ...files];

    // Devolver un nuevo directorio
    return Dir(dirName: name, documents: docs);
  }

  @override
  String toString() {
    return 'Dir{documents: $documents, dirName: $dirName}';
  }
}
