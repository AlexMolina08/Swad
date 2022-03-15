
/// Modelo de una peticion de búsqueda de un usuario
class SearchRequest{
  final userRole , courseCode,filter;
  SearchRequest({required this.userRole, required this.courseCode, required this.filter});
}
