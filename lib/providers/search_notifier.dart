import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/find_user_request.dart';
import 'package:untitled/repository/swad_repository.dart';
import 'package:untitled/states/search_state.dart';

class SearchNotifier extends StateNotifier<SearchState>{

  SwadRepository swadRepo ; // Repositorio para hacer las llamadas Swad

  SearchNotifier(this.swadRepo)
    : super(
      SearchInitial()
    );

  ///
  /// Buscar usuarios cuyo firstname obtenga la cadena filter .
  /// se debe especificar el rol y el codigo del cuso
  /// (<0 en ambos, toda la plataforma swad)
  ///
  Future<void> find(String userRole , String courseCode , String filter) async{

    try{
      /// Ateneder la peticion y notificar de que está cargando
      state = SearchLoading();
      final searchData = await swadRepo.findUsers(filter,userRole,courseCode);
      /// actualizar el estado a cargado , inicializandolo con los datos
      /// de búsqueda obtenidos
      state = searchData;

    } on Exception catch (e) {
      // en caso de error el estado pasa a error
      state = SearchError("La búsqueda ha fallado");

    }

  }


}