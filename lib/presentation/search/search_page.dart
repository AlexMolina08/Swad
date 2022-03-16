import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/providers/search_provider.dart';
import 'package:untitled/states/search_state.dart';
import 'matches_grid.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  /// Estado del filtro de búsqueda
  /// se actualiza utilizando setState()
  /// Es un estado efímero (únicamente necesario en esta pantalla)
  String filter = "";

  /// filtro de busqueda en la searchBar

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);

    /// Se llama a findUserProvider para obtener coincidencias con el filtro actual
    //AsyncValue<String> searchResults = ref.watch(searchProvider);

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          ExploreAppBar(
            onSubmitted: (String currentFilter) async {
              await ref
                  .read(searchNotifierProvider.notifier)
                  .find("0", "0", currentFilter);
            },
          ),


          showGridView(searchState),

        ],
      ),
    );
  }

  Widget showGridView(SearchState state){

    switch(state.runtimeType){

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
        return MatchesGrid(
          searchState: state as SearchLoaded,
        );

      default:
        return const SliverToBoxAdapter(
          child: Text("Busca a un estudiante o profesor"),
        );


    }

  }

}




