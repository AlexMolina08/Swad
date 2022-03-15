import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/providers/search_provider.dart';
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
    var filter = "";

    /// Se llama a findUserProvider para obtener coincidencias con el filtro actual
    //AsyncValue<String> searchResults = ref.watch(searchProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            ExploreAppBar(
              onSubmitted: (String currentFilter) async {
                await ref
                    .read(searchNotifierProvider.notifier)
                    .find("0", "0", currentFilter);
              },
            ),
            MatchesGrid(
              searchState: searchState,
            )
          ],
        ),
      ),
    );
  }
}


