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

  final userListResponse;
  late List<dynamic> users ;
  final int numUsers;


  /// CONSTRUCTOR
   SearchLoaded({this.userListResponse,required numUsers})
   /// Inicializar variable con el numero de usuarios encontrados en la búsqueda
   /// si numUsers es < 0 (ocurre cuando no encuentra matches)
   /// se inicializa a 0
   : numUsers = numUsers <= 0 ? 0 : numUsers
   {

     print("\n\nNº MATCHES : $numUsers\n\n");
     // a partir del numero de usuarios , construimos la lista


     /// Si recibe una lista con más de un elemento , asignar a
     /// userListResponse
    if(numUsers > 1 && userListResponse is List<dynamic>) {
      print("RESPONSE DATA : ${userListResponse.runtimeType.toString()}");
      users = userListResponse;
    }
    /// Si  el numero de users es 0 , devolver lista vacia
    else if (numUsers <= 0){
      users = List.empty();
    }
    /// Si únicamente hay un elemento inicializar ArrayList users con ese elemento
    else{
      users = [userListResponse]; // inicializamos users con un arraylist a 1
    }

  }


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


