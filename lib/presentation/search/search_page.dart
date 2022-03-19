import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/HideNavBar.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/presentation/search/explore_appbar.dart';
import 'package:untitled/providers/search_providers/search_provider.dart';
import 'package:untitled/states/search_state.dart';
import 'package:untitled/utilities/constants.dart';

class SearchPage extends ConsumerStatefulWidget {


  SearchPage() ;

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  /// ---
  var usersGrids =  [];
  var controller;

  @override
  void didChangeDependencies() {
    //super.dependOnInheritedWidgetOfExactType();
    super.didChangeDependencies();
  }

  @override
  void initState() {

    ref.read(hideNavBarProvider).controller.addListener(() {

      SearchState state = ref.read(searchNotifierProvider);

      /// combrobar si se ha llegado al final del scrollview
      if (controller.position.pixels == controller.position.maxScrollExtent
          && state is SearchLoaded) {

        if(usersGrids.length < state.numUsers){
          /// comprobar si quedan grids por mostrar
          int itemsLeft = state.numUsers - usersGrids.length;

          /// añadir más items a la vista (dependiendo de los que falten añadirlos todos
          /// o kUsersPerPage)
          List<dynamic> nextItems ;

          if(itemsLeft < kUsersPerPage){

            nextItems = List<dynamic>.from(state.users).sublist(usersGrids.length-1);

            print("ITEMS::: ${nextItems.runtimeType}");

          }else{

            nextItems = List<dynamic>.from(state.users).sublist(
                usersGrids.length-1 , /// inicio
                (usersGrids.length-1)+kUsersPerPage); /// fin

            print("ITEMS::: ${nextItems.runtimeType}");


          }

          usersGrids.insertAll(usersGrids.length,nextItems);

          setState(() {});

        }


      }



    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SearchState searchState = ref.watch(searchNotifierProvider);

    controller = ref.watch(hideNavBarProvider).controller;

    /// Se llama a findUserProvider para obtener coincidencias con el filtro actual
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          ExploreAppBar(
            onSubmitted: (String currentFilter) async {
              /// limpiar buffer con la lista visible (usersGrid)
              if (usersGrids.isNotEmpty) usersGrids.clear();

              /// Llamar a Find en la API
              await ref
                  .read(searchNotifierProvider.notifier)
                  .find("0", "0", currentFilter);

            },
          ),
          SliverToBoxAdapter(
              child: (searchState is SearchLoaded)
                  ? Text(
                      "NumUsers: ${searchState.numUsers},UsersGridCount:${usersGrids.length}")
                  : Text('')),
          showSearchView(searchState),
        ],
      ),
    );
  }

  /// Comprobar el estado actual de la búsqueda y devolver widget adecuado
  Widget showSearchView(SearchState state) {
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



        if(searchResult.users.isNotEmpty){

          if(usersGrids.isEmpty) {
            /// comprobar si la lista está vacia y su tamaño
            if (searchResult.numUsers < kUsersPerPage) {
              /// añadir todos los usuarios a la lista de grids
              usersGrids = List<dynamic>.from(searchResult.users);
            } else {
              /// añadir los n primeros usuarios a la lista de grids
              usersGrids = List<dynamic>.from(searchResult.users).sublist(0, kUsersPerPage);
            }
            setState((){});
          }

          /// SLIVER GRID
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: (MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height) *
                  2,
            ),

            /// metodo para renderizar cada elemento de la lista en el gridview
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  var user = User.fromJson(usersGrids[index]);

                  return Container(
                    child: GridTile(
                      footer: Text(
                        "${user.firstName} ${user.surName1} ${user.surName2}",
                        textAlign: TextAlign.center,
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: user.photoUrl != null
                            ? Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(user.photoUrl),
                          ),
                        )
                            : Image(
                            image:
                            AssetImage('resources/no_user_photo.png'),
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.height / 5),
                      ),
                    ),
                  );
                }, childCount: usersGrids.length),
          );



        }else{
          return const SliverToBoxAdapter(
            child: Text("Nada por aquí"),
          );
        }

        ///##################################################################
        ///##################################################################

      default:
        return const SliverToBoxAdapter(
          child: Text("Busca a un estudiante o profesor"),
        );
    }
  }

}

/**
 *
 *
 * /// listener: Escuchar cuando se ha llegado al final del gridview
 * /// y quedan más resultados por cargar
   scrollController.addListener(() {
    if (scrollController.position.pixels ==
    scrollController.position.maxScrollExtent &&
    usersGridsCount < searchResult.numUsers) {
    if (searchResult.numUsers - usersGridsCount < kUsersPerPage) {
    /// si no podemos añadir 18 (valor de kUsersPerPage),
    /// establecer el numero de items disponibles

    } else {

    }
    }
 */
