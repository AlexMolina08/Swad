/**
 *
 * Model de datos para manejar los estados de la búsqueda
 *
 */

/// clase representa un estado de la búsqueda
abstract class SearchState {
  const SearchState();
}

///
///
/// Implementación de los estados de la búsqueda
///

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {


  final List<dynamic>? users;
  final String numUsers;



  const SearchLoaded({this.users,required this.numUsers});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchLoaded &&
          runtimeType == other.runtimeType &&
          users == other.users &&
          numUsers == other.numUsers;

  @override
  int get hashCode => users.hashCode ^ numUsers.hashCode;
}

class SearchError extends SearchState {

  final String message;
  const SearchError(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SearchError &&
              runtimeType == other.runtimeType &&
              message == other.message;

  @override
  int get hashCode => message.hashCode;

}


