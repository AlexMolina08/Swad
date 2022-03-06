import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/providers/search_provider.dart';
import 'package:untitled/states/search_state.dart';

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
              onSubmitted: (String currentFilter) async{
                await ref.read(searchNotifierProvider.notifier).find("0", "0", currentFilter);
              },
            ),
            SliverToBoxAdapter(

              child: SearchView(
                searchState
              ),

            ),
          ],
        ),
      ),
    );
  }
}

class SearchView extends StatelessWidget {

  final SearchState searchState;


  SearchView(this.searchState);

  @override
  Widget build(BuildContext context) {

    if (searchState is SearchInitial)
      return Text("Busca a cualquier usuario");
    else if (searchState is SearchLoading)
      return CircularProgressIndicator();

    if(searchState is SearchLoaded){
      var search = searchState as SearchLoaded;

      return Text(search.users.toString());

   }else{
      return Text("ERROR");
    }

  }
}

