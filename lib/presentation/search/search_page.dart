import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/providers/search_providers/search_notifier.dart';
import 'package:untitled/providers/search_providers/search_provider.dart';
import 'package:untitled/states/search_state.dart';
import 'matches_grid.dart';
import 'package:untitled/utilities/constants.dart';

class SearchPage extends ConsumerStatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  var scrollController = ScrollController();
  var usersGridsCount ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// filtro de busqueda en la searchBar

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);

    /// Se llama a findUserProvider para obtener coincidencias con el filtro actual
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        //physics: BouncingScrollPhysics(),
        slivers: [
          ExploreAppBar(
            onSubmitted: (String currentFilter) async {

              var currentSearchState = ref
                  .read(searchNotifierProvider.notifier);

              await currentSearchState
                  .find("0", "0", currentFilter);

              if(searchState is SearchLoaded)
                setState(() => usersGridsCount = 18);



            },
          ),
          SliverToBoxAdapter(
            child: (searchState is SearchLoaded) ? Text("NumUsers: ${searchState.numUsers},UsersGridCount:${usersGridsCount}")
                : Text('')
          ),
          showGridView(searchState),
        ],
      ),
    );
  }

  /// Mostrar un grid view con los usuarios que coinciden con la búsqueda.
  /// Comprobar el estado actual de la búsqueda y devolver widget adecuado
  Widget showGridView(SearchState state) {
    switch (state.runtimeType) {
      case SearchLoading:
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

      case SearchError:
        return const SliverToBoxAdapter(
          child: Center(
            child: Icon(Icons.error_outline_sharp),
          ),
        );

      case SearchLoaded:
        var searchResult = state as SearchLoaded;

        /// listener: Escuchar cuando se ha llegado al final del gridview
        /// y quedan más resultados por cargar

        scrollController.addListener(() {

          if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent &&
              usersGridsCount < searchResult.numUsers) {
            if (searchResult.numUsers - usersGridsCount < kUsersPerPage) {
              /// si no podemos añadir 18 (valor de kUsersPerPage),
              /// establecer el numero de items disponibles
              setState(() {
                print("*** USERS GRID COUNT: $usersGridsCount ***");
                usersGridsCount +=  searchResult.numUsers - usersGridsCount;
              });
            } else {
              /// aumentar usersGridsCount
              setState(() {
                print("*** USERS GRID COUNT: $usersGridsCount ***");
                usersGridsCount += kUsersPerPage;
              });
            }
          }
        });

        return MatchesGrid(
            searchResult: state as SearchLoaded,
            usersGridCount: usersGridsCount);

      default:
        return const SliverToBoxAdapter(
          child: Text("Busca a un estudiante o profesor"),
        );
    }
  }
}
